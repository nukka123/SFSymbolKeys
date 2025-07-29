# SFSymbolKeys

[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE.txt)
[![SwiftPM compatible](https://img.shields.io/badge/SwiftPM-compatible-brightgreen.svg)](https://swift.org/package-manager/)

SFSymbolKeys is a Swift library that allows you to use SF Symbols names as typo-safe identifiers, helping to prevent typing mistakes.

With the Raw Identifier syntax introduced in Swift 6.2, SF Symbols names can be used directly as identifiers (e.g., `` `9.square.fill` ``).

> **Note:** This library is in the early stages of development. The API may change in future versions.

> (日本語版) [README-ja.md](./README-ja.md)

## Features

- Identifiers matching SF Symbols names (Raw Identifier)
- Prevent typos by using identifiers
- Compile-time OS version checks via `@available` attributes

## Requirements

- Xcode 26 or later (Swift compiler 6.2 or later required)

## Installation

### Swift Package Manager

Add the following to the `dependencies` in your `Package.swift` file:

```swift
.package(url: "https://github.com/nukka123/SFSymbolKeys.git", from: "0.0.1")
```

Add `SFSymbolKeys` to your dependencies:

```swift
.target(
    name: "YourApp",
    dependencies: [
        .product(name: "SFSymbolKeys", package: "SFSymbolKeys")
    ]
)
```

### Xcode

1. In Xcode, go to "File" > "Add Packages...".
2. Enter the repository URL in the search bar:

   ```
   https://github.com/nukka123/SFSymbolKeys.git
   ```
3. For "Dependency Rule", select "Up to Next Major Version" and specify the version as `0.0.1`.
4. Click "Add Package".
5. Add the `SFSymbolKeys` library to your app's target.


## Usage

### Basic usage

This library provides the `SFSymbolKey` type, which wraps SF Symbols names, and static constants corresponding to each SF Symbol name.

```swift
import SFSymbolKeys
// SF Symbols names can be safely referenced as Raw Identifiers
let symbolKey: SFSymbolKey = .`9.square.fill`
let image = UIImage(systemName: symbolKey.name)
```

### Example usage with SwiftUI

This library does not provide SwiftUI-specific extensions. Please implement any necessary extensions yourself.

> Tips: For possible extension methods, search for `systemName:` or `systemImage:` on Apple's documentation site.

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

### Appendix: SF Symbols Versions

For details on SF Symbols versions and supported OS versions, see [SFSymbolVersions.md](Docs/SFSymbolVersions.md).

### Appendix: List of SFSymbolKeys by version

For those who want to use a list of SF Symbols, we provide an experimental API to get lists by version.

```swift
let symbolKeys1_0: [SFSymbolKey] = SFSymbolKey.keysV1_0
let symbolKeys7_0: [SFSymbolKey] = SFSymbolKey.keysV7_0
```

> WARNING: This feature is experimental and may change in future versions.

## Disclaimer

- The author cannot guarantee continuous or timely maintenance of this library. Instead, you can easily add new SF Symbols yourself in the future. (See [About Library Development](#about-library-development))
- The author's English is not fluent. This documentation relies on GPT and translation tools.

## License

This library is provided under the MIT License. See [LICENSE.txt](./LICENSE.txt) for details.

## About Library Development

The identifiers provided by the SFSymbolKeys library are implemented via code generation using [Tools/SFSymbolKeyCodeGen](Tools/SFSymbolKeyCodeGen/).
For details, see the [README.md](Tools/SFSymbolKeyCodeGen/README.md) of this tool.
