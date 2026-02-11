# MarkdownDual

Minimal macOS app that opens `.md` files in both [Bike](https://www.hogbaysoftware.com/bike/) and [Marked 2](https://marked2app.com/) simultaneously.

## Requirements

- macOS
- [Bike](https://www.hogbaysoftware.com/bike/)
- [Marked 2](https://marked2app.com/)
- [duti](https://github.com/moretension/duti) (`brew install duti`)

## Install

```sh
make install
```

This builds the `.app` bundle, copies it to `~/Applications`, registers it with Launch Services, and sets it as the default handler for `.md` files.

## Uninstall

```sh
make uninstall
```

## How it works

MarkdownDual is a thin `.app` bundle wrapping a shell script. When macOS opens a `.md` file with it, the script passes the file to both Bike and Marked 2 via `open -a`. The `Info.plist` declares the `net.daringfireball.markdown` UTI so macOS recognizes it as a valid handler for markdown files.
