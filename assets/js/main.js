
/**
 * main.js - script ringan untuk antarmuka Pemira HIMATEP
 * Fungsi yang digunakan di beberapa halaman (mis. auto-refresh, fetch hasil)
 */
 (function () {
    // Auto refresh for admin dashboard/results if desired
    function setupAutoRefresh(delayMs = 30000) {
        try {
            setTimeout(function refresh() {
                if (document.visibilityState === 'visible') {
                    // reload page to update realtime numbers
                    window.location.reload();
                }
                setTimeout(refresh, delayMs);
            }, delayMs);
        } catch (e) {
            console.error('Auto-refresh gagal:', e);
        }
    }

    // Fetch JSON hasil voting via endpoint (jika Anda tambahkan endpoint API)
    async function fetchResultsJson(url) {
        try {
            const res = await fetch(url, { credentials: 'same-origin' });
            if (!res.ok) throw new Error('Network response not ok');
            return await res.json();
        } catch (e) {
            console.error('fetchResultsJson error:', e);
            return null;
        }
    }

    // Utility: confirm action
    function confirmAction(message) {
        return confirm(message);
    }

    // Expose beberapa fungsi ke window jika dibutuhkan
    window.Pemira = {
        setupAutoRefresh,
        fetchResultsJson,
        confirmAction
    };

    // Jika pada admin pages, aktifkan auto-refresh
    if (window.location.pathname.includes('/admin/')) {
        setupAutoRefresh(30000); // 30s
    }
})();