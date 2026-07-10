# コンテンツ・画像更新ガイド

サイトの文章、公開アプリ、画像、言語表示を更新するときの手順です。

## 表示文を変更する

表示文は`lib/content/site_content.dart`で管理しています。

- 日本語: `SiteContent.ja`
- 英語: `SiteContent.en`

見出し、ナビゲーション、フォームのラベル・エラー文、プライバシーポリシーまで
同じファイルにあります。片方だけ内容が古くならないよう、原則としてJA / ENを同時に
更新してください。

変更後はローカルで`/`と`/en`を開き、文章の折り返しとボタン幅を確認します。

## 言語判定とURL

言語判定とURL変換は`lib/services/locale/site_locale.dart`、手動選択の保存は
`lib/services/locale/locale_preference_store*.dart`が担当します。

優先順位は次の通りです。

1. `/en`など、URLに明示された言語
2. ヘッダーで選択して保存された言語
3. ブラウザの先頭言語（`ja`で始まる場合のみ日本語）
4. 上記以外は英語

言語を追加するときは、コンテンツだけでなく`SiteLanguage`、ルーティング、メタデータ、
テストも同時に更新します。

## 公開アプリを更新する

アプリ情報はJA / ENそれぞれの`WorksContent.items`にある`AppWork`で管理します。

更新対象:

- `title`: 表示名
- `summary`: 短い概要
- `tech`: 使用技術
- `note`: 工夫した点
- `url`: App Store URL
- `iconAsset`: アイコン画像
- `screenshotAsset`: 縦長の紹介画像

アプリを追加・削除するときはJA / ENの件数と並び順を揃えてください。

## 画像を差し替える

現在の画像構成は次の通りです。

```text
assets/apps/coffee_timer/icon.jpg
assets/apps/coffee_timer/screenshot.jpg
assets/apps/volume_changer/icon.jpg
assets/apps/volume_changer/screenshot.jpg
assets/apps/recipe_archive/icon.jpg
assets/apps/recipe_archive/screenshot.jpg
```

推奨仕様:

| 用途 | 推奨サイズ・比率 | 表示方法 |
| --- | --- | --- |
| アプリアイコン | 512×512、正方形 | 枠いっぱいに表示 |
| 紹介画像 | 約600×1300、縦長 | 全体が見えるよう`contain`で表示 |
| OGP | 1200×630 | `web/og.png` |

同じファイル名で差し替える場合も、`pubspec.yaml`のassets宣言と実機表示を確認します。
新しいディレクトリを追加する場合は、JA / ENの`AppWork`と`pubspec.yaml`を更新します。

縦長紹介画像は横長に拡大トリミングせず、文字や端末全体が見える状態を維持してください。

## OGP・検索表示を変更する

- 初期HTMLのメタデータ: `web/index.html`
- 共有画像: `web/og.png`
- 画面遷移後のメタデータ: `lib/services/metadata/`
- ページ固有の文言: `SiteContent.ja` / `SiteContent.en`

ドメインを変更するときはcanonical、hreflang、OGP URLをまとめて変更してください。

## 更新後の確認

```bash
dart format --output=none --set-exit-if-changed lib test
flutter analyze
flutter test
flutter build web --release
```

最低限、デスクトップ幅と390px前後のスマートフォン幅で、次を目視します。

- ヘッダーとHeroの折り返し
- 実績パネルの3項目
- Works画像が切れていないこと
- JA / EN切り替え後も同じページを維持すること
- ContactとPrivacyの言語・URL
