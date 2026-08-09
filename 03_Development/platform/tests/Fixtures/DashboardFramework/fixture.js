const supportedLocales = ['ko-KR', 'vi-VN', 'en-US'];
const fallbackLocale = 'en-US';
const preferenceKey = 'fup-demo-locale';
let fallbackMessages = {};

async function loadMessages(locale) {
  const response = await fetch(`../../../assets/dashboard-framework/locales/${locale}.json`);
  if (!response.ok) throw new Error(`Locale unavailable: ${locale}`);
  return response.json();
}

function translate(messages, key) {
  return messages[key] ?? fallbackMessages[key] ?? `[missing:${key}]`;
}

async function applyLocale(locale, persist = true) {
  const safeLocale = supportedLocales.includes(locale) ? locale : fallbackLocale;
  fallbackMessages = Object.keys(fallbackMessages).length ? fallbackMessages : await loadMessages(fallbackLocale);
  const messages = safeLocale === fallbackLocale ? fallbackMessages : await loadMessages(safeLocale);
  document.documentElement.lang = safeLocale;
  document.querySelectorAll('[data-i18n]').forEach((element) => { element.textContent = translate(messages, element.dataset.i18n); });
  document.querySelectorAll('[data-i18n-aria]').forEach((element) => { element.setAttribute('aria-label', translate(messages, element.dataset.i18nAria)); });
  document.querySelectorAll('[data-number]').forEach((element) => { element.textContent = new Intl.NumberFormat(safeLocale, { maximumFractionDigits: 2 }).format(1234567.89); });
  document.querySelectorAll('[data-date]').forEach((element) => { element.textContent = new Intl.DateTimeFormat(safeLocale, { dateStyle: 'medium', timeZone: 'Asia/Ho_Chi_Minh' }).format(new Date('2026-08-09T09:00:00+07:00')); });
  document.querySelectorAll('[data-locale]').forEach((button) => { button.setAttribute('aria-pressed', String(button.dataset.locale === safeLocale)); });
  if (persist) localStorage.setItem(preferenceKey, safeLocale);
}

document.querySelectorAll('[data-locale]').forEach((button) => button.addEventListener('click', () => applyLocale(button.dataset.locale)));

const menuButton = document.querySelector('.fup-mobile-menu');
const navigation = document.querySelector('#framework-navigation');
if (menuButton instanceof HTMLButtonElement && navigation instanceof HTMLElement) {
  const compact = window.matchMedia('(max-width: 63.999rem)');
  const synchronizeNavigation = () => {
    if (compact.matches) {
      navigation.hidden = menuButton.getAttribute('aria-expanded') !== 'true';
    } else {
      navigation.hidden = false;
      menuButton.setAttribute('aria-expanded', 'false');
    }
  };
  menuButton.addEventListener('click', () => {
    menuButton.setAttribute('aria-expanded', String(menuButton.getAttribute('aria-expanded') !== 'true'));
    synchronizeNavigation();
  });
  compact.addEventListener('change', synchronizeNavigation);
  synchronizeNavigation();
}

const storedLocale = localStorage.getItem(preferenceKey);
const browserLocale = navigator.languages.find((locale) => supportedLocales.includes(locale));
applyLocale(storedLocale ?? browserLocale ?? fallbackLocale, false);
