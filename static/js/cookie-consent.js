/**
 * Cookie Consent Manager
 * Stores choice in localStorage. Gates ad-container visibility on consent.
 * - "accepted"  → show ads
 * - "rejected"   → hide ads, disable non-essential tracking
 * - not set      → show banner, ads stay hidden until choice
 */
(function () {
  var KEY = 'hk_cookie_consent';
  var banner = document.getElementById('cookie-consent');
  if (!banner) return;

  // If already chosen, don't show banner
  var choice = localStorage.getItem(KEY);
  if (choice) {
    applyConsent(choice);
    return;
  }

  // Show banner
  banner.hidden = false;

  document.getElementById('cookie-accept').addEventListener('click', function () {
    localStorage.setItem(KEY, 'accepted');
    applyConsent('accepted');
    hideBanner();
  });

  document.getElementById('cookie-reject').addEventListener('click', function () {
    localStorage.setItem(KEY, 'rejected');
    applyConsent('rejected');
    hideBanner();
  });

  document.getElementById('cookie-dismiss').addEventListener('click', function () {
    // Dismiss without choice — ads stay hidden, banner reappears next visit
    hideBanner();
  });

  function hideBanner() {
    banner.classList.add('cookie-consent--hiding');
    setTimeout(function () { banner.hidden = true; }, 350);
  }

  function applyConsent(level) {
    var adContainers = document.querySelectorAll('.ad-container');
    if (level === 'accepted') {
      // Show ad placeholders so the ad network can fill them
      adContainers.forEach(function (el) { el.style.display = ''; });
      // Fire a custom event ad networks can listen to
      document.dispatchEvent(new CustomEvent('cookieConsent', { detail: { consent: true } }));
    } else {
      // rejected — remove ad containers from layout entirely
      adContainers.forEach(function (el) { el.style.display = 'none'; });
      document.dispatchEvent(new CustomEvent('cookieConsent', { detail: { consent: false } }));
    }
  }
})();
