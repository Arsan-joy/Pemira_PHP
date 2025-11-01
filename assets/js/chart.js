/**
 * assets/js/chart-updates.js
 * Utility untuk membuat dan memperbarui Chart.js pada halaman admin/results.php
 *
 * Fitur:
 * - Inisialisasi dua chart (Kahim & Senat)
 * - Polling otomatis ke endpoint API (api/results.php) untuk refresh data
 * - Fungsi untuk membuat/merubah data chart tanpa reload halaman
 * - Error handling & backoff sederhana saat fetch gagal
 * - Eksport chart sebagai image (PNG)
 *
 * Cara pakai (contoh pada admin/results.php):
 *
 * <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
 * <script src="../assets/js/chart-updates.js"></script>
 * <script>
 *   const apiUrl = '../api/results.php';
 *   const updater = new PemiraCharts({
 *     apiUrl,
 *     pollInterval: 10000, // ms
 *     kahimCanvas: document.getElementById('chartKahim'),
 *     senatCanvas: document.getElementById('chartSenat')
 *   });
 *   updater.start(); // mulai polling & render chart
 * </script>
 *
 * Catatan:
 * - Endpoint API harus mengembalikan JSON sesuai spec api/results.php (requires admin session)
 * - Pastikan Chart.js sudah diload sebelum file ini
 */

(function (window) {
  'use strict';

  // Default palette (dipakai bergantian)
  const DEFAULT_PALETTE = [
    '#1f77b4', '#ff7f0e', '#2ca02c', '#d62728', '#9467bd',
    '#8c564b', '#e377c2', '#7f7f7f', '#bcbd22', '#17becf'
  ];

  // Helper: generate warna sebanyak n
  function generateColors(n) {
    const colors = [];
    for (let i = 0; i < n; i++) {
      colors.push(DEFAULT_PALETTE[i % DEFAULT_PALETTE.length]);
    }
    return colors;
  }

  // Helper: safe number
  function toInt(v) {
    const n = parseInt(v, 10);
    return Number.isFinite(n) ? n : 0;
  }

  // Create bar chart instance
  function createBarChart(canvasEl, labels = [], data = [], opts = {}) {
    if (!canvasEl) throw new Error('Canvas element required for createBarChart');

    const ctx = canvasEl.getContext('2d');
    const colors = opts.colors || generateColors(data.length);

    const chart = new Chart(ctx, {
      type: 'bar',
      data: {
        labels: labels,
        datasets: [{
          label: opts.datasetLabel || 'Jumlah Suara',
          data: data,
          backgroundColor: colors,
          borderColor: colors.map(c => c),
          borderWidth: 1
        }]
      },
      options: {
        maintainAspectRatio: false,
        responsive: true,
        plugins: {
          legend: { display: false },
          tooltip: {
            callbacks: {
              label: function (context) {
                const y = context.parsed.y ?? context.parsed;
                return `${y} suara`;
              }
            }
          }
        },
        scales: {
          x: {
            ticks: { maxRotation: 45, minRotation: 0 }
          },
          y: {
            beginAtZero: true,
            precision: 0
          }
        }
      }
    });

    return chart;
  }

  // Update existing chart with new labels & data
  function updateBarChart(chart, labels, data) {
    if (!chart) return;
    chart.data.labels = labels;
    chart.data.datasets[0].data = data;
    // update colors length if needed
    const colors = generateColors(data.length);
    chart.data.datasets[0].backgroundColor = colors;
    chart.data.datasets[0].borderColor = colors;
    chart.update();
  }

  // Fetch JSON from API with proper credentials
  async function fetchJson(url) {
    const res = await fetch(url, {
      method: 'GET',
      credentials: 'same-origin',
      headers: {
        'Accept': 'application/json'
      }
    });
    if (!res.ok) {
      const text = await res.text().catch(() => '');
      const err = new Error('Network response not ok: ' + res.status);
      err.status = res.status;
      err.body = text;
      throw err;
    }
    return await res.json();
  }

  // Export chart image (download PNG)
  function exportChartAsImage(chart, filename = 'chart.png') {
    if (!chart) return;
    const link = document.createElement('a');
    link.download = filename;
    link.href = chart.toBase64Image();
    document.body.appendChild(link);
    link.click();
    link.remove();
  }

  // Main class for managing charts & polling
  class PemiraCharts {
    constructor(options = {}) {
      if (!options.apiUrl) throw new Error('apiUrl is required');
      if (!options.kahimCanvas || !options.senatCanvas) {
        throw new Error('kahimCanvas and senatCanvas (canvas elements) are required');
      }

      this.apiUrl = options.apiUrl;
      this.pollInterval = options.pollInterval || 10000;
      this.kahimCanvas = options.kahimCanvas;
      this.senatCanvas = options.senatCanvas;
      this.onError = options.onError || function () { };
      this.onUpdate = options.onUpdate || function () { };

      this._kahimChart = null;
      this._senatChart = null;
      this._pollTimer = null;
      this._running = false;

      // backoff state
      this._failCount = 0;
      this._maxBackoff = options.maxBackoff || 6; // up to 2^6 * interval
    }

    // Initialize charts with optional initial data snapshot
    init(initialData = null) {
      // initialData expected to have {kahim: [], senat: [], stats: {...}}
      let kahimLabels = [];
      let kahimData = [];
      let senatLabels = [];
      let senatData = [];

      if (initialData && initialData.kahim) {
        kahimLabels = initialData.kahim.map(c => `${c.nama} (No.${c.nomor_urut})`);
        kahimData = initialData.kahim.map(c => toInt(c.total_votes));
      }
      if (initialData && initialData.senat) {
        senatLabels = initialData.senat.map(c => `${c.nama} (No.${c.nomor_urut})`);
        senatData = initialData.senat.map(c => toInt(c.total_votes));
      }

      // If charts already exist, destroy first
      try { if (this._kahimChart) this._kahimChart.destroy(); } catch (e) { /* ignore */ }
      try { if (this._senatChart) this._senatChart.destroy(); } catch (e) { /* ignore */ }

      this._kahimChart = createBarChart(this.kahimCanvas, kahimLabels, kahimData);
      this._senatChart = createBarChart(this.senatCanvas, senatLabels, senatData);
    }

    // Single refresh (fetch + update charts & optionally stats)
    async refreshOnce() {
      try {
        const json = await fetchJson(this.apiUrl);
        // update charts
        const kahimLabels = (json.kahim || []).map(c => `${c.nama} (No.${c.nomor_urut})`);
        const kahimData = (json.kahim || []).map(c => toInt(c.total_votes));
        const senatLabels = (json.senat || []).map(c => `${c.nama} (No.${c.nomor_urut})`);
        const senatData = (json.senat || []).map(c => toInt(c.total_votes));

        if (!this._kahimChart || !this._senatChart) {
          this.init(json);
        } else {
          updateBarChart(this._kahimChart, kahimLabels, kahimData);
          updateBarChart(this._senatChart, senatLabels, senatData);
        }

        // reset fail/backoff
        this._failCount = 0;

        // Callback for external UI updates (stats/table)
        try { this.onUpdate(json); } catch (e) { console.error(e); }

        return json;
      } catch (err) {
        this._failCount++;
        try { this.onError(err); } catch (e) { console.error(e); }
        // throw err for caller if needed
        throw err;
      }
    }

    // Start polling loop
    start() {
      if (this._running) return;
      this._running = true;

      // initial immediate refresh
      this.refreshOnce().catch(e => {
        console.warn('Initial refresh failed', e);
      });

      const loop = async () => {
        if (!this._running) return;
        // compute dynamic delay with backoff
        const backoff = Math.min(this._failCount, this._maxBackoff);
        const delay = this.pollInterval * Math.pow(2, backoff);
        this._pollTimer = setTimeout(async () => {
          try {
            await this.refreshOnce();
          } catch (e) {
            // handled in refreshOnce -> onError
          } finally {
            if (this._running) loop();
          }
        }, delay);
      };

      loop();
    }

    // Stop polling
    stop() {
      this._running = false;
      if (this._pollTimer) {
        clearTimeout(this._pollTimer);
        this._pollTimer = null;
      }
    }

    // Force immediate refresh and return promise
    async forceRefresh() {
      return await this.refreshOnce();
    }

    // Export both charts as images (triggers downloads)
    exportAll(prefix = 'pemira') {
      if (this._kahimChart) exportChartAsImage(this._kahimChart, `${prefix}-kahim.png`);
      if (this._senatChart) exportChartAsImage(this._senatChart, `${prefix}-senat.png`);
    }

    // Expose chart instances
    get kahimChart() { return this._kahimChart; }
    get senatChart() { return this._senatChart; }
  }

  // Expose PemiraCharts to window.PemiraCharts
  window.PemiraCharts = PemiraCharts;

})(window);