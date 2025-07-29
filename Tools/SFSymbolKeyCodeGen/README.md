# SFSymbolKeyCodeGen

This package is a set of tools for code generation for the `SFSymbolKeys` library.
It exists as a completely independent tool from the `SFSymbolKeys` library.

> NOTE: The command examples below assume your current directory is `SFSymbolKeys/Tools/SFSymbolKeyCodeGen/`.

> (日本語版) [README-ja.md](./README-ja.md)

## Required Development Environment

- macOS environment with Xcode 26 or later (Swift compiler 6.2 or later) installed is required.

## SFSymbolKeyCodeGen

Generates code that defines identifiers for `SFSymbolKey` from the list of SF Symbols names loaded by SFSymbolKeyResource.

The generated code is output to `SFSymbolKeys/Sources/SFSymbolKeys/Generated/`.

### Example:

> $ swift run SFSymbolKeyCodeGen

## SFSymbolVersionMDGen

Generates a Markdown list of SF Symbols versions from the version information loaded by SFSymbolKeyResource.

The generated Markdown is output to `SFSymbolKeys/Docs/SFSymbolVersions.md`.

### Example:

> $ swift run SFSymbolVersionMDGen

## SFSymbolKeyResource

This is the core internal library of this development tool.

Builds data models representing SF Symbols version information and name lists from the data in [Resource](Sources/SFSymbolKeyResource/Resource/).

### Resource/config.json

Set the SF Symbols versions and supported OSes as confirmed from Apple's SF Symbols app.
Based on the versions set here, the name list files are loaded.

### Resource/vX.Y.txt (e.g. v1.0.txt)

These are lists of SF Symbols names corresponding to each version of SF Symbols.
They are manually copied from Apple's SF Symbols app.

> INFO: For convenience, these files are referred to as RawKey files.

## How to Add New SF Symbols

When a new version of SF Symbols is released, update/add the files in Resource and run CodeGen and MDGen.

To get the list of SF Symbols names, you need the [SF Symbols app](https://developer.apple.com/sf-symbols/) released by Apple. Unfortunately, the name list files (RawKey files) must be created manually.

Follow the steps below to obtain the list of names:

* Update the SF Symbols app to the latest version and launch it
* Switch to list view
* In the sidebar, select `all` under the `SF Symbols` category
* Sort the `Name` column in ascending order
* Sort the `Availability` column in ascending order
* Select the rows corresponding to the latest SF Symbol version
* Right-click and select "Copy Names" from the context menu
