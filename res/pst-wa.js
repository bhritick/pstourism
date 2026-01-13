// Ensures all PSTourism WhatsApp CTAs are safe and consistent.
// Policy: href must be exactly https://wa.me/8240002684
(() => {
  const WHATSAPP_URL = 'https://wa.me/8240002684';

  const normalize = () => {
    const anchors = document.querySelectorAll('a[href]');
    anchors.forEach((a) => {
      const href = a.getAttribute('href');
      if (!href) return;

      // Normalize legacy/variant WhatsApp links
      const isWa = href.startsWith('https://wa.me/') || href.startsWith('http://wa.me/');
      if (!isWa) return;

      a.setAttribute('href', WHATSAPP_URL);
      a.setAttribute('target', '_blank');
      a.setAttribute('rel', 'noopener noreferrer');
    });
  };

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', normalize);
  } else {
    normalize();
  }
})();
