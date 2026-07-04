# tm_developer_site

TM Developer の個人LPです。Flutter Webで作成し、Firebase Hostingで公開します。

## Local Preview

通常の作業確認は、Flutter web-serverを固定ポートで起動します。

```bash
flutter run -d web-server --web-hostname 127.0.0.1 --web-port 8081
```

確認URL:

```text
http://127.0.0.1:8081/
```

このURLを作業者とCodexが同時に確認します。

- Dart側のUI修正は基本的にこのまま反映確認できます。
- 画面が白い場合は、古いFlutterプロセスが残っている可能性があります。起動中のターミナルで `q`、または `Ctrl + C` で停止してから再起動します。
- `curl -I` のHEAD確認はFlutter web-serverで404になる場合があります。ブラウザ表示確認、またはGET確認を使います。

## Production-like Preview

`web/index.html`、`web/manifest.json`、Firebase設定、メタデータを触った時は、ビルド後にFirebase Hosting Emulatorで確認します。

```bash
flutter build web
firebase emulators:start --only hosting --project tm-developer-site
```

確認URL:

```text
http://127.0.0.1:5000/
```

## Deploy

デプロイは作業者側で実行します。

```bash
flutter build web
firebase deploy --only hosting --account tm.developer58@gmail.com
```

Firebase認証が切れている場合のみ、先に再認証します。

```bash
firebase login --reauth --account tm.developer58@gmail.com
```
