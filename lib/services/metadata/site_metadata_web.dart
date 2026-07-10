import 'package:web/web.dart' as web;

const _siteOrigin = 'https://tm-developer-site.web.app';

void updateSiteMetadata({
  required String languageCode,
  required String title,
  required String description,
  required String currentPath,
  required String japanesePath,
  required String englishPath,
}) {
  final locale = languageCode == 'ja' ? 'ja_JP' : 'en_US';
  final alternateLocale = languageCode == 'ja' ? 'en_US' : 'ja_JP';
  final canonicalUrl = _absoluteUrl(currentPath);

  web.document.documentElement?.setAttribute('lang', languageCode);
  web.document.title = title;

  _setMeta('name', 'description', description);
  _setMeta('property', 'og:type', 'website');
  _setMeta('property', 'og:site_name', 'TM Developer');
  _setMeta('property', 'og:title', title);
  _setMeta('property', 'og:description', description);
  _setMeta('property', 'og:url', canonicalUrl);
  _setMeta('property', 'og:locale', locale);
  _setMeta('property', 'og:locale:alternate', alternateLocale);
  _setMeta('property', 'og:image', '$_siteOrigin/og.png');
  _setMeta('name', 'twitter:card', 'summary_large_image');
  _setMeta('name', 'twitter:title', title);
  _setMeta('name', 'twitter:description', description);
  _setMeta('name', 'twitter:image', '$_siteOrigin/og.png');

  _setLink('canonical', canonicalUrl);
  _setAlternateLink('ja', _absoluteUrl(japanesePath));
  _setAlternateLink('en', _absoluteUrl(englishPath));
  _setAlternateLink('x-default', _absoluteUrl('/'));
}

String _absoluteUrl(String path) {
  if (path == '/') {
    return '$_siteOrigin/';
  }
  return '$_siteOrigin$path';
}

void _setMeta(String attribute, String key, String content) {
  final selector = 'meta[$attribute="$key"]';
  final element =
      web.document.querySelector(selector) ??
      web.document.createElement('meta');
  element
    ..setAttribute(attribute, key)
    ..setAttribute('content', content);
  if (!element.isConnected) {
    web.document.head?.append(element);
  }
}

void _setLink(String relation, String href) {
  final selector = 'link[rel="$relation"]';
  final element =
      web.document.querySelector(selector) ??
      web.document.createElement('link');
  element
    ..setAttribute('rel', relation)
    ..setAttribute('href', href);
  if (!element.isConnected) {
    web.document.head?.append(element);
  }
}

void _setAlternateLink(String language, String href) {
  final selector = 'link[rel="alternate"][hreflang="$language"]';
  final element =
      web.document.querySelector(selector) ??
      web.document.createElement('link');
  element
    ..setAttribute('rel', 'alternate')
    ..setAttribute('hreflang', language)
    ..setAttribute('href', href);
  if (!element.isConnected) {
    web.document.head?.append(element);
  }
}
