# LSP Servers

System packages needed for the LSP configuration.

## Servers

| Server | Arch Package | AUR Package | macOS (Homebrew) |
|--------|-------------|-------------|------------------|
| lua-language-server | `lua-language-server` | - | `brew install lua-language-server` |
| vtsls | - | `vtsls` | `npm install -g @vtsls/language-server` |
| tailwindcss-language-server | - | `tailwindcss-language-server` | `npm install -g @tailwindcss/language-server` |
| vscode-eslint-language-server | - | `vscode-langservers-extracted` | `npm install -g vscode-langservers-extracted` |
| basedpyright | - | `basedpyright` | `brew install basedpyright` |
| ruff | `ruff` | - | `brew install ruff` |
| clangd | `clang` | - | `brew install llvm` |
| gopls | `gopls` | - | `brew install gopls` |
| docker-langserver | - | `dockerfile-language-server` | `npm install -g dockerfile-language-server-nodejs` |
| yaml-language-server | - | `yaml-language-server` | `npm install -g yaml-language-server` |
| vscode-json-language-server | - | `vscode-langservers-extracted` | `npm install -g vscode-langservers-extracted` |
| taplo | `taplo` | - | `brew install taplo` |
| vscode-html-language-server | - | `vscode-langservers-extracted` | `npm install -g vscode-langservers-extracted` |
| zls | `zls` | - | `brew install zls` |
| harper-ls | - | `harper` | `brew install harper` |
| rust-analyzer | `rust-analyzer` | - | `brew install rust-analyzer` |
| roslyn + rzls | (via Mason) | - | (via Mason) |
| jdtls | - | `jdtls` | `brew install jdtls` |

## Install Commands

### Arch Linux

Official repos:
```bash
pacman -S lua-language-server ruff clang gopls taplo zls rust-analyzer
```

AUR:
```bash
yay -S vtsls basedpyright vscode-langservers-extracted yaml-language-server tailwindcss-language-server dockerfile-language-server harper jdtls
```

### macOS

Homebrew:
```bash
brew install lua-language-server basedpyright ruff llvm gopls taplo zls harper rust-analyzer jdtls
```

npm:
```bash
npm install -g @vtsls/language-server @tailwindcss/language-server vscode-langservers-extracted yaml-language-server dockerfile-language-server-nodejs
```

## Notes

- `vscode-langservers-extracted` provides eslint, json, html, and css language servers
- On macOS with llvm from Homebrew, clangd is at `/opt/homebrew/opt/llvm/bin/clangd`
- roslyn (C#) is best installed via Mason as it has complex dependencies
