# サイト仕様

## 目的

TM DeveloperがFlutter / Firebaseで対応できる範囲、公開アプリ、稼働条件を伝え、
小規模なアプリ開発・改修の相談につなげる個人向け仕事窓口LPです。

公開URL:

```text
https://tm-developer-site.web.app/
https://tm-developer-site.firebaseapp.com/
```

## ページとURL

| Page | Japanese | English | Purpose |
| --- | --- | --- | --- |
| Home | `/` | `/en` | 実績・スキル・働き方・相談導線 |
| Contact | `/contact` | `/en/contact` | メールまたはフォームで問い合わせ |
| Privacy | `/privacy` | `/en/privacy` | 取得情報・Analytics・外部リンク等の説明 |

URLは`usePathUrlStrategy()`を使ったhashなしの形式です。Firebase Hostingでは
`** -> /index.html`のrewriteを設定し、各URLへの直接アクセスに対応します。

## 言語表示

対応言語は日本語と英語です。

- 明示的な言語別URLを優先する
- `/`では保存済みの手動選択を優先する
- 未選択時はブラウザの先頭言語が`ja`で始まる場合のみ日本語にする
- 上記以外は英語にする
- ヘッダー切り替えでは現在のHome / Contact / Privacyを維持する
- 手動選択はlocalStorageへ保存する

表示文は`lib/content/site_content.dart`、判定とURLは
`lib/services/locale/site_locale.dart`で管理します。

## Home構成

1. Header: セクションナビゲーション、JA / EN、相談ボタン
2. Hero: 対応領域、相談・GitHub導線、公開アプリ画像
3. Metrics: 公開アプリ、最大月間利用実績、週稼働目安
4. About: 個人開発・運用経験
5. Works: App Store公開アプリ、技術、担当範囲、工夫
6. Skills: Flutter / Firebase / App Store関連スキル
7. Work Style: 稼働日数、リモート、連絡方法
8. Contact: メールとFirestoreフォーム
9. Footer: サイト情報とプライバシーポリシー

## デザイン・レスポンシブ

- 最大コンテンツ幅: 1180px
- 基本色: navy、blue、white、light gray
- Heroは広い画面で文章とアプリ画像を2カラムにする
- Metricsは広い画面で3列、狭い画面で縦積みにする
- Worksは広い画面で3列、狭い画面で1列にする
- 縦長のWorks画像は`contain`で全体を表示し、中央拡大トリミングしない
- 390px前後のスマートフォン幅で横方向のoverflowを出さない

テーマは`lib/theme/site_theme.dart`、共通レイアウトは`lib/widgets/`で管理します。

## Contactフォーム

問い合わせ方法は次の2つです。

- メールアプリを開くリンク
- Cloud Functions経由でFirestoreへ保存するフォーム

フォーム項目:

| Field | Required | Max length |
| --- | --- | --- |
| `name` | yes | 50 |
| `email` | yes | 100 |
| `subject` | yes | 100 |
| `message` | yes | 1000 |

Firestore仕様:

- Collection: `contactMessages`
- 固定値: `status = new`、`source = contact_form`
- `createdAt`はserver timestamp
- ブラウザからのread / create / update / deleteは禁止
- Callable FunctionのAdmin SDKだけが作成・通知状態更新を行う
- Function側で必須項目、型、文字数、メール形式を検証する
- App Checkを必須化する
- IPを秘密値でハッシュ化し、10分3回・24時間10回に制限する
- 回数制限レコードは24時間の有効期限とFirestore TTLを使う
- 内容はFirebase Consoleで確認する

WebではFirebase App CheckのreCAPTCHA v3を使用します。サイトキーはクライアント設定、
secret keyはFirebase Consoleで管理し、リポジトリへ保存しません。

問い合わせ保存後はGmailへ全文を通知し、問い合わせ者メールを`Reply-To`へ設定します。
通知失敗は問い合わせ保存を失敗扱いにせず、`notificationStatus`とCloud Loggingへ残します。

## メタデータとOGP

- 初期HTML: `web/index.html`
- 画面遷移後: `lib/services/metadata/`
- OGP画像: `web/og.png`（1200×630）

ページと言語に合わせてtitle、description、canonical、hreflang、HTML langを更新します。

## Analytics

Google Analytics 4で次を計測します。

- `page_view`
- `contact_click`
- `contact_submit_success`
- `contact_submit_failure`
- `contact_rate_limited`
- `github_click`
- `app_card_click`

localhost、127.0.0.1、空のhostnameではイベントを送信しません。詳細は
[アクセス解析仕様](analytics.md)を参照してください。

## Hostingとキャッシュ

Firebase Hostingの公開ディレクトリは`build/web`です。Flutter Webの古い生成物が
残りにくいよう、次へ`Cache-Control: no-cache`を設定します。

```text
/index.html
/flutter_bootstrap.js
/flutter_service_worker.js
/main.dart.js
/version.json
```

## 公開ファイルの方針

コミットするもの:

- Flutterソース、テスト、assets、webファイル
- READMEと`docs/`
- `firebase.json.example`
- `firestore.rules`と`firestore.indexes.json`

コミットしないもの:

- `.firebaserc`とローカルの`firebase.json`
- `.env`、サービスアカウントJSON
- reCAPTCHA secret key、管理者権限の認証情報
- Firebase EmulatorやFlutterの生成物

## 受け入れ条件

- JA / ENのHome、Contact、Privacyを直接URLから開ける
- 自動言語判定と手動切り替えが仕様どおり動く
- デスクトップとスマートフォンでレイアウトが崩れない
- Works画像全体が表示される
- App Store、GitHub、メールリンクが正しい
- Contactフォームの検証とFirestore保存が動く
- 回数制限、Gmail通知、通知状態記録が動く
- Analyticsで送信成功・失敗・回数制限を区別できる
- `flutter analyze`と`flutter test`が成功する
- ブラウザコンソールに新規エラーがない
