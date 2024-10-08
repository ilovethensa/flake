## Highlights

These are the Nix/NixOS configurations for my homelab servers, desktop and laptop

- ❄️ Nix flakes handle upstream dependencies, tracks unstable channel of Nixpkgs
- 🏠 [home-manager](https://github.com/nix-community/home-manager) manages
  dotfiles 
- 🤫 [sops-nix](https://github.com/Mic92/sops-nix) manages secrets 
- 🌬️ Root on tmpfs aka impermanence 
- 🧩 Home-assistant, Jellyfin, among other nice
  self-hosted applications 
- ⚡️ `justfile` contains useful aliases for many frequent and atrociously long
  `nix` commands 
- 🤖 `flake.lock` updated daily via GitHub Action, servers are configured to 
  automatically upgrade

| Hostname   |        Board            |       CPU         |  RAM  |          Primary GPU           | Role |  OS  | State |
|:----------:|:-----------------------:|:-----------------:|:-----:|:------------------------------:|:----:|:----:|:-----:|
| `viper`    |     AX370-Gaming K5     | AMD Ryzen 7 1700  | 16GB  |        Gigabyte RX580          |  🖥️  |  ❄️   |  ✅   |
| `mute`     |      ThinkPad L560      |   Intel i5-6200U  |  8GB  | Intel® Iris® Pro Graphics 6200 |  💻️  |  ❄️   |  ✅   |
| `ikaros`   |   Gigabyte B150-HD3-CF  |   Intel G4560     |  8GB  |     Intel HD Graphics 610      |  🗄️  |  ❄️   |  ✅   |
| `slash`    |        H11M-r           |   Intel i7-6700   | 16GB  |           GTX 1050             |  🖥️  |  ❄️   |  ❌   |
| `renegade` | Librecomputers Renegade |      RK3328       |  4GB  |         ARM Mali-450           |  🗄️  |  🍓  |  ❌   |

**Key**

- 🖥️ : Desktop
- 💻️ : Laptop
- 🗄️ : Server