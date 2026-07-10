# アクセス解析仕様

## 方針

Webサイトの訪問と相談導線を把握するため、Google Analytics 4を使用します。
Firebase Analyticsではなく、Webデータストリームの`gtag.js`を直接読み込みます。

実装ファイル:

- `web/index.html`
- `lib/services/analytics/analytics_service.dart`
- `lib/services/analytics/analytics_service_web.dart`

localhost、127.0.0.1、空のhostnameではイベントを送信しません。

## 計測イベント

| Event | Parameters | Purpose |
| --- | --- | --- |
| `page_view` | GA4標準値 | ページ閲覧 |
| `contact_click` | `source` | 相談導線の利用 |
| `contact_submit_success` | なし | Firestore保存成功 |
| `contact_submit_failure` | `reason` | Callable送信失敗 |
| `contact_rate_limited` | なし | 回数制限による拒否 |
| `github_click` | `source` | GitHub導線の利用 |
| `app_card_click` | `app_name`, `url` | App Store導線の利用 |

`contact_click`の現在のsource:

```text
hero
contact_email_option
contact_form
```

`github_click`の現在のsource:

```text
hero
```

問い合わせの名前、メールアドレス、件名、本文、IPハッシュはAnalyticsへ送信しません。

## イベントを追加する

1. `AnalyticsService`に用途が分かるメソッドを追加する
2. Web実装から`tmAnalyticsTrackEvent`を呼び出す
3. 個人情報や問い合わせ本文をparameterへ含めない
4. localhostで送信されないことを確認する
5. 本番デプロイ後にGA4 RealtimeまたはDebugViewで確認する

追加候補:

- `language_switch`
- `section_view`
- `external_link_click`

## プライバシー

プライバシーポリシーには、Google Analytics、Cookie等による閲覧状況の取得、
個人を直接特定する目的ではないことを記載します。Analyticsの仕様を変更した場合は、
JA / EN両方のポリシーも確認してください。

測定IDはWeb配信に含まれる公開識別子です。サービスアカウントや管理者権限の認証情報は
別物として扱い、リポジトリへ保存しません。
