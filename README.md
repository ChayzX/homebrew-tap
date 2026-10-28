# PingOne Promote Homebrew tap

Installation previews for [PingOne Promote](https://github.com/ChayzX/pingone-promote).

```sh
brew install chayzx/tap/pingone-promote
pingone-promote --version
pingone-runner --version
pingone-promote
```

Homebrew builds both commands from versioned, SHA-256-verified release sources. Go is installed as a build dependency; the commands need no separate language runtime. The app opens a local browser interface and no background service is registered.

```sh
brew update
brew upgrade chayzx/tap/pingone-promote
brew uninstall --force pingone-promote
```

Stop the app before upgrading. Profiles, history and Keychain credentials are outside Homebrew's package directory and are preserved on uninstall; session-only credentials disappear when the app exits.

This is an installation preview. Live PingOne promotion/rollback and macOS Keychain acceptance remain outstanding. Production planning, deployment and rollback stay controlled by GitLab.

[Installation and release notes](https://github.com/ChayzX/pingone-promote/releases/tag/v0.2.0-rc.1) · [macOS Apple Silicon, macOS Intel and Linux package checks](https://github.com/ChayzX/pingone-promote/actions/runs/40738259975)
