# SFSymbolKeys

[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE.txt)
[![SwiftPM compatible](https://img.shields.io/badge/SwiftPM-compatible-brightgreen.svg)](https://swift.org/package-manager/)

SFSymbolKeys は、SF Symbols の名前を、タイピング安全な識別子で利用可能にするSwiftライブラリです。

Swift 6.2 で導入された Raw Identifier 構文により、SF Symbols の名前が、そのまま識別子 (例: `` `9.square.fill` ``) として利用可能です。

> (日本語版) [README-ja.md](./README-ja.md)

## 特長

- SF Symbolsの名前と同じ識別子が利用可能 (Raw Identifier)
- 識別子の利用によるタイプミスの防止
- `@available`属性によるコンパイル時のOSバージョンチェック

## 必要な開発環境

- Xcode 26 以上（Swiftコンパイラ 6.2 以上）が必要です。

## インストール

### Swift Package Manager

`Package.swift`に以下を追加してください。

```swift
.package(url: "https://github.com/あなたのユーザー名/SFSymbolKeys.git", from: "1.0.0")
```

dependencies に `SFSymbolKeys` を追加します。

```swift
.target(
    name: "YourApp",
    dependencies: [
        .product(name: "SFSymbolKeys", package: "SFSymbolKeys")
    ]
)
```

### Xcode

1. Xcodeのメニューバーから「File」>「Add Packages...」を選択します。
2. 検索欄に以下のURLを入力します。
   
   ```
   https://github.com/あなたのユーザー名/SFSymbolKeys.git
   ```
3. バージョン指定（例: "Up to Next Major" 1.0.0）を選択し、「Add Package」をクリックします。
4. 対象ターゲットに`SFSymbolKeys`を追加してください。

## 使い方

### 基本的な使い方

このライブラリは、SF Symbols名をラップする `SFSymbolKey`型と、SF Symbols名に対応したstatic定数を提供します。

```swift
import SFSymbolKeys
// SF Symbols名が、そのままRaw Identifierで安全に参照できます
let symbolKey: SFSymbolKey = .`9.square.fill`
let image = UIImage(systemName: symbolKey.name)
```

### SwiftUIでの利用例

本ライブラリはSwiftUI用の拡張メソッドを直接提供しません。ユーザー側で必要な拡張を実装してください。

> Tips: 実装候補となるメソッドは、Apple の Document サイトから `systemName:` または `systemImage:` で検索してみてください。

```swift
import SwiftUI
import SFSymbolKeys

extension Image {
    init(symbolKey: SFSymbolKey) {
        self.init(systemName: symbolKey.name)
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Image(symbolKey: .`9.square.fill`)
            Text("Hello SFSymbolKey World!")
        }
    }
}
```

### 付録: SF Symbols のバージョン

SF Symbols のバージョン と 利用可能なOSバージョンについては [SFSymbolVersions.md](Docs/SFSymbolVersions.md) を参照ください。

### 付録: バージョン別のSFSymbolKeyのリスト

SF Symbolの一覧を利用したい人のために、バージョン別のリストを取得するAPIを実験的に用意しています。

```swift
let symbolKeys1_0: [SFSymbolKey] = SFSymbolKey.keysV1_0
let symbolKeys7_0: [SFSymbolKey] = SFSymbolKey.keysV7_0
```

> WARNING: この機能は実験的なAPIです。将来バージョンで変更する可能性があります。

## 免責事項

- 作者は、このライブラリの継続的かつタイムリーなメンテナンスを保証できません。その代わり、将来のSFSymbolの追加が、あなた自身の作業によって容易に実施可能です。([ライブラリの開発について](#ライブラリの開発について) を参照)
- 作者の英語能力は貧弱です。GPTおよび翻訳ツールに頼っています。

## ライセンス

このライブラリはMITライセンスで提供されています。詳細は[LICENSE.txt](./LICENSE.txt)をご覧ください。

## ライブラリの開発について

SFSymbolKeys のライブラリが提供する識別子は、[Tools/SFSymbolKeyCodeGen](Tools/SFSymbolKeyCodeGen/) によるコード生成で実装しています。詳しくは、このツールの [README.md](Tools/SFSymbolKeyCodeGen/README.md) を参照してください。
