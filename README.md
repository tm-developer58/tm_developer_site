# tm_developer_site

TM Developerの個人向け仕事窓口LPです。Flutter / Firebaseでのアプリ開発実績、
対応領域、稼働条件、お問い合わせ導線を日本語・英語で掲載します。

- Production: <https://tm-developer-site.web.app/>
- English: <https://tm-developer-site.web.app/en>

## Features

- Flutter WebによるレスポンシブLP
- App Storeで公開している個人開発アプリの紹介
- 日本語・英語の自動判定と手動切り替え
- 言語別URL、ページタイトル、description、canonical / hreflangの更新
- メールリンクとFirestore問い合わせフォーム
- Firebase App Check（reCAPTCHA v3）
- Google Analytics 4（ローカル環境では送信しない）
- Firebase Hostingへのデプロイ

## Tech stack

- Flutter / Dart
- Firebase Hosting
- Cloud Firestore / Firebase Security Rules
- Firebase App Check
- Google Analytics 4

## Local development

依存関係を取得し、ローカルWebサーバーを起動します。

```bash
flutter pub get
flutter run -d web-server --web-hostname 127.0.0.1 --web-port 8081
```

確認URLは <http://127.0.0.1:8081/> です。変更後は次を実行します。

```bash
dart format --output=none --set-exit-if-changed lib test
flutter analyze
flutter test
flutter build web --release
```

## Documentation

- [サイト仕様](docs/site-spec.md)
- [コンテンツ・画像更新ガイド](docs/content-guide.md)
- [アクセス解析仕様](docs/analytics.md)
- [リリース・確認チェックリスト](docs/release-checklist.md)

## Project structure

```text
assets/apps/                 App Store掲載画像
lib/content/                 JA / ENの表示文と実績データ
lib/pages/                   Home / Contact / Privacyページ
lib/sections/                LP内の各セクション
lib/services/locale/         言語判定・URL・選択保存
lib/services/metadata/       title / description / canonical更新
lib/services/contact/        Firestore問い合わせ送信
lib/theme/                   サイト共通テーマ
lib/widgets/                 共通UI
test/                        Widget / locale / routingテスト
web/                         OGP、favicon、Webメタデータ
```

## Localization routes

| Page | Japanese | English |
| --- | --- | --- |
| Home | `/` | `/en` |
| Contact | `/contact` | `/en/contact` |
| Privacy | `/privacy` | `/en/privacy` |

`/`への初回アクセスでは、保存済みの手動選択、ブラウザ言語の順で表示言語を
決定します。ブラウザ言語が`ja`で始まる場合だけ日本語、それ以外は英語です。
明示的な言語別URLと、ヘッダーで選択した言語が優先されます。

## Contact form and security

フォーム送信はFirestoreの`contactMessages`コレクションへ保存します。
`firestore.rules`では作成のみを許可し、読み取り・更新・削除を禁止しています。
フィールド、文字数、メール形式、初期ステータスもRules側で検証します。

Firebase Web設定は`lib/firebase_options.dart`、App CheckのreCAPTCHA v3サイトキーは
同ファイルの既定値を使用します。別プロジェクトで上書きする場合は次を指定します。

```bash
flutter build web --release \
  --dart-define=FIREBASE_APP_CHECK_RECAPTCHA_SITE_KEY=YOUR_SITE_KEY
```

サービスアカウントJSON、秘密鍵、管理者権限の認証情報はコミットしません。

## Deployment

Firebase Hostingの公開ディレクトリは`build/web`です。

```bash
flutter build web --release
firebase deploy --only hosting
```

Firestore Rulesを変更した場合だけ、必要に応じて次も実行します。

```bash
firebase deploy --only firestore:rules
```

詳細な確認項目は[リリース・確認チェックリスト](docs/release-checklist.md)を参照してください。
