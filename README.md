# tm_developer_site

TM Developer の個人LPです。Flutter Webで作成し、Firebase Hostingで公開します。

## Stack

- Flutter Web
- Firebase Hosting
- Google Analytics 4

## Development

Run checks before changing deploy-related files.

```bash
flutter analyze
flutter test
```

Build for web:

```bash
flutter build web
```

## Firebase Contact Form

Contact form submissions are saved to the `contactMessages` Firestore
collection. Firebase Web config is defined in `lib/firebase_options.dart`.

App Check uses the reCAPTCHA v3 site key defined in
`lib/firebase_options.dart`. To override it for another Firebase project, pass:

```bash
--dart-define=FIREBASE_APP_CHECK_RECAPTCHA_SITE_KEY=...
```

Firestore rules are in `firestore.rules`.
