# Minimal Flutter Template
<img width="675" alt="截屏2024-02-03 16 42 00" src="https://github.com/KentaIbayashi/minimal_flutter_template/assets/18243238/eb0ddaa5-dd93-4327-98a4-05f37d8bfafb">

## 概要
このプロジェクトは、riverpodとgo_routerを核として構築されており、ダイアログ、ストレージなどの基本的な機能も包括的に取り入れた、シンプルで使いやすいテンプレートとなっています。また、デザイン面ではMaterial 3のガイドラインに従っています。

## 主要ライブラリ
- [flutter_riverpod](https://pub.dev/packages/flutter_riverpod)
- [go_router](https://pub.dev/packages/go_router)
- [freezed](https://pub.dev/packages/freezed)
- [flutter_smart_dialog](https://pub.dev/packages/flutter_smart_dialog)
- [get_it](https://pub.dev/packages/get_it)
- [logger](https://pub.dev/packages/logger)
- [shared_preferences](https://pub.dev/packages/shared_preferences)
- [dio](https://pub.dev/packages/dio)

## 実装済みフィーチャー
- ✅ ルーティング(riverpodとgo_routerのインテグレーション)
- ✅ ローディング表示やダイアログなどのオーバーレイ
- ✅ ライトモードとダークモードの切り替え(適切なMaterial 3の使用)
- ✅ 依存性注入(get_itを利用したDependency Injection)
- ✅ レスポンシブ

## 未実装フィーチャー
- ❌ API通信(dio,モックサーバー)
- ❌ データモデル作成(freezed)


## Thanks

If something is missing or you want to add some feature, feel free to open a ticket or contribute!

[LICENSE: MIT](LICENSE)
