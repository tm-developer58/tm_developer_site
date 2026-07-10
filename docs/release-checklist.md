# リリース・確認チェックリスト

Firebase Hostingへ公開するときの手順です。デプロイ操作は公開権限を持つ担当者が行います。

## 1. 変更内容を確認する

```bash
git status --short
git diff --check
```

- 秘密鍵、サービスアカウントJSON、個人情報が含まれていない
- JA / ENの文章と公開アプリ情報が揃っている
- `web/index.html`と`web/og.png`の内容が一致している
- Firestore Rulesの変更有無を把握している

## 2. 品質チェックを実行する

```bash
dart format --output=none --set-exit-if-changed lib test
flutter analyze
flutter test
flutter build web --release
```

すべて成功してから`build/web`を公開します。

## 3. ローカルで最終確認する

```bash
flutter run -d web-server --web-hostname 127.0.0.1 --web-port 8081
```

<http://127.0.0.1:8081/>を開き、デスクトップ幅とスマートフォン幅で確認します。

- `/`は日本語環境で日本語になる
- 日本語以外のブラウザ言語では`/en`へ切り替わる
- JA / ENボタンが現在のページを保って切り替える
- Hero、実績パネル、Works画像に崩れがない
- App Store、GitHub、メールリンクが正しい
- Contactフォームの必須・メール形式・文字数エラーが表示される
- Privacyページが両言語で表示される
- ブラウザコンソールに新規エラーがない

## 4. Firebaseへデプロイする

Hostingのみを更新する場合:

```bash
firebase deploy --only hosting
```

Firestore Rulesも更新する場合:

```bash
firebase deploy --only firestore:rules
```

## 5. 公開後に確認する

次のURLを直接開きます。

```text
https://tm-developer-site.web.app/
https://tm-developer-site.web.app/en
https://tm-developer-site.web.app/contact
https://tm-developer-site.web.app/en/contact
https://tm-developer-site.web.app/privacy
https://tm-developer-site.web.app/en/privacy
```

確認項目:

- 最新の実績パネルとWorks画像が表示される
- 直接URLを開いても404にならない
- canonical / hreflang / title / descriptionがページと言語に合っている
- OGP画像が`1200×630`で取得できる
- 問い合わせ送信が成功し、Firestoreの`contactMessages`へ保存される
- Google Analytics 4の本番イベントが必要に応じて取得できる

古い画面が残る場合は、デプロイ完了を確認してからハードリロードまたはプライベート
ブラウズで再確認します。`firebase.json`では主要なFlutter Web生成物を`no-cache`に
しています。
