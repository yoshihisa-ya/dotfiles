# dotfiles
My dotfiles.

## platform
Arch Linux での利用を中心としています。
自宅サーバや、職場の WSL2 環境で Debian bullseye を利用しているので、 Debian bullseye でもターミナルやエディタ関連は動作します。
ごく一部の環境で FreeBSD を利用してるので、 FreeBSD でも動作する可能性が有ります。
macOS 及び (WSL2を除く)Microsoft Windows は一切考慮しておらず、動作しません。

## install
dotfiles の管理には [chezmoi](https://www.chezmoi.io/) を利用しています。

```
$ sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply yoshihisa-ya
```

## machine setup
Arch Linux のセットアップ手順を Wiki に掲載しています。
