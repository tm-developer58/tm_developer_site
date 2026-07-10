# 問い合わせバックエンド設定

問い合わせフォームはCloud Functionsの`submitContactMessage`を経由します。ブラウザから
Firestoreへ直接書き込む構成ではありません。

## 処理の流れ

1. FlutterがCallable Functionへ名前・メール・件名・本文を送る
2. App Checkトークンを検証する
3. Function側でも型、必須、文字数、メール形式を検証する
4. 接続元を秘密値でHMAC-SHA256ハッシュ化する
5. Firestore Transactionで回数制限と問い合わせ保存を同時に処理する
6. Gmailで`tm.developer58@gmail.com`へ全文を通知する
7. 問い合わせ者のメールアドレスを`Reply-To`へ設定する

通知に失敗しても問い合わせ保存は成功扱いです。`notificationStatus`を`failed`にして、
Cloud Loggingへ本文を含まないエラーを記録します。

## 回数制限

- 同じ接続元から10分間に3回まで
- 同じ接続元から24時間に10回まで
- 超過時は`resource-exhausted`を返す
- IPアドレス自体は保存しない
- `contactRateLimits.expiresAt`は作成・更新から24時間後
- Firestore TTLにより、期限後は通常24時間以内に削除される

TTL削除は即時ではありません。期限を過ぎたレコードは回数判定には使われません。

## 事前準備

Cloud Functionsの公開にはFirebaseプロジェクトのBlazeプランが必要です。

Gmailは2段階認証を有効にし、メール送信用のApp Passwordを作成します。通常のGoogle
アカウントパスワードは使用しません。Gmail通知は低頻度の個人サイト向けです。配信量や
信頼性要件が上がった場合は、専用のトランザクションメールサービスへ移行します。

## Secretsを設定する

リポジトリへ値を保存せず、Firebase CLIの入力欄へ直接入力します。

```bash
firebase functions:secrets:set GMAIL_APP_PASSWORD
firebase functions:secrets:set CONTACT_RATE_LIMIT_PEPPER
```

`GMAIL_APP_PASSWORD`にはGmailの16文字App Passwordを設定します。
`CONTACT_RATE_LIMIT_PEPPER`には十分に長いランダム文字列を設定します。値はチャット、
README、`.env`へ貼り付けません。

## 検証する

```bash
cd functions
npm install
npm test
npm audit --omit=dev
cd ..

dart format --output=none --set-exit-if-changed lib test
flutter analyze
flutter test
flutter build web --release
```

## デプロイ順序

Secrets設定後、FunctionとTTL設定を先に公開します。既存フォームを公開中も使えるよう、
この時点ではSecurity Rulesを変更しません。

```bash
firebase deploy --only functions,firestore:indexes
```

Functionが利用できることを確認してからHostingを公開し、最後にブラウザからのFirestore
直接書き込みを禁止します。

```bash
flutter build web --release
firebase deploy --only hosting
firebase deploy --only firestore:rules
```

## 本番確認

- 正常送信でFirestoreへ`contactMessages`が作成される
- `notificationStatus`が`sent`になる
- Gmailへ全文通知が届く
- Gmailの返信操作で問い合わせ者メールが宛先になる
- 4回目の連続送信がJA / ENの回数制限メッセージになる
- GA4で`contact_submit_success`と`contact_rate_limited`を確認できる
- Functionsログへ問い合わせ本文やメールアドレスが出力されない
