# dotfiles
My dotfiles.

## platform
Arch Linux での利用を中心としています。
自宅サーバや、職場の WSL2 環境で Debian bullseye を利用しているので、 Debian bullseye でもターミナルやエディタ関連は動作します。
ごく一部の環境で FreeBSD を利用してるので、 FreeBSD でも動作する可能性が有ります。
macOS 及び (WSL2を除く)Microsoft Windows は一切考慮しておらず、動作しません。

## install
dotfiles の管理には [chezmoi](https://www.chezmoi.io/) を利用しています。

`~/.config/chezmoi/chezmoi.toml` を作成してください。
```
[data]
    owner = "me"
    role = "desktop"
    packageInstall = "disable"
    email = "your-email-address@example.com"
    githubEnterpriseAddress = "github.example.com"
    githubEnterpriseUsername = "your-github-username"
```

これらの情報や、ホスト名、ユーザ名、ディストリビューションの情報を参考に、個人のワークステーションと判定した場合は、システムのパッケージマネージャを用いた変更が行われます。

- owner
  - me: 個人用途としてセットアップします。この構成では、ファイル共有やパスワードマネージャを用いる場合に、 Syncthing, Bitwarden の利用を前提とします。
  - 組織ドメイン(ex:example.com): 組織マシンとしてセットアップします。主に職場用としてセットアップする場合に用います。この構成では、 ファイル共有やパスワードマネージャー などは、その組織のポリシーに従います。また、組織固有の情報は、 GitHub Enterprise に存在するものとします。
- role
  - desktop: デスクトップ用途としてセットアップします。
  - terminal: ターミナル用途としてセットアップします。
- packageInstall: owner もしくは role の値によっては、暗黙的に disable になります。
  - enable: システムのパッケージマネージャを用いて、パッケージをインストールします。
  - check: システムのパッケージマネージャを用いますが、不足パッケージの確認のみを行い、実際のインストールは実施しません。
  - disable: システムのパッケージマネージャを用いません。
- email: ~/.gitconfig や、 MUA の 署名設定に用いられます。
- githubEnterpriseAddress: 組織用としてセットアップする際、追加の情報を取得するための、 GitHub Enterprise の FQDN を指定します。
- githubEnterpriseUsername: 組織用としてセットアップする際、追加の情報を取得するための、 GitHub Enterprise のユーザ名を指定します。

作成したら、 chezmoi のインストールと、 dotfiles を適用します。
```
$ sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply yoshihisa-ya
```

## machine setup
Arch Linux のセットアップ手順を Wiki に掲載しています。
