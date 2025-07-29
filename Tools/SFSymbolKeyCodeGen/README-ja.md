# SFSymbolKeyCodeGen

このパッケージは、`SFSymbolKeys` ライブラリのコード生成を行うツール群です。
`SFSymbolKeys` ライブラリとは完全に独立したツールとして存在します。

> NOTE: 以下で紹介するコマンド実行例は、`SFSymbolKeys/Tools/SFSymbolKeyCodeGen/` を現在ディレクトリとした前提で説明します。

> (日本語版) [README-ja.md](./README-ja.md)

## 必要な開発環境

- Xcode 26 以上（Swiftコンパイラ 6.2 以上）をインストールした macOS 環境が必要です。

## SFSymbolKeyCodeGen

SFSymbolKeyResource で読み込んだ SF Symbols の名前一覧から、`SFSymbolKey` の識別子を定義するコードを生成します。

生成したコードは `SFSymbolKeys/Sources/SFSymbolKeys/Generated/` の場所に出力されます。

### 実行例:

> $ swift run SFSymbolKeyCodeGen

## SFSymbolVersionMDGen

SFSymbolKeyResource で読み込んだ SF Symbols のバージョン情報から、バージョン一覧の Markdown を生成します。

生成した Markdown は `SFSymbolKeys/Docs/SFSymbolVersions.md` の場所に出力されます。

### 実行例:

> $ swift run SFSymbolVersionMDGen

## SFSymbolKeyResource

この開発ツールのコア機能となる内部ライブラリです。

[Resource](Sources/SFSymbolKeyResource/Resource/) のデータから、SF Symbols のバージョン情報や名前一覧を表現するデータモデルを構築します。

### Resource/config.json

Apple の SF Symbols アプリから確認できた SF Symbols のバージョンおよび対応OSを設定します。
ここで設定したバージョンを基に、名前一覧ファイルを読み込みます。

### Resource/vX.Y.txt (e.g. v1.0.txt)

SF Symbols のバージョンに対応した、SF Symbols の名前一覧です。
Apple の SF Symbols アプリから手作業でコピーして作成します。

> INFO: このファイルを便宜的にRawKeyファイルと呼んでいます。

## 新しい SF Symbols の追加方法

新しい SF Symbols がリリースされたときは、Resourceのファイルを更新・追加し、CodeGenとMDGenを実行します。

SF Symbols の名前を把握するには Apple がリリースする [SF Symbols アプリ](https://developer.apple.com/jp/sf-symbols/) が必要です。そして残念ながら、名前一覧ファイル（RawKeyファイル）は手作業で作成する必要があります。

以下の手順に従って、名前の一覧を取得します。

* SF Symbols アプリ を最新版に更新し、起動する
* リスト表示にする。
* サイドバーの `SF Symbols` カテゴリ は `all` を選択
* `Name` 列を、昇順にする
* `Availability` 列を、昇順にする
* 最新の SF Symbol バージョン に対応する行項目を 複数選択する
* 右クリックメニューから、選択項目の名前をコピーする。
