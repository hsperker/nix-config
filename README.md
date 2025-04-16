# nix-config

My personal Nix configuration for macOS, featuring a modern development environment with Neovim, Tmux, and various system optimizations.

## Features

### System Configuration
- **nix-darwin**: System configuration for macOS
- **Homebrew Integration**: Managed through nix-darwin
- **System Preferences**: Optimized defaults for macOS
- **Security**: TouchID for sudo authentication
- **Window Management**: Aerospace window manager with custom keybindings
- **Visual Enhancements**: JankyBorders for window borders

### Development Environment
- **Neovim**: Latest nightly version with custom configuration
- **Tmux**: Terminal multiplexer with custom setup
- **Starship**: Modern shell prompt
- **Fonts**: Atkinson Hyperlegible and JetBrains Mono

### Applications
- **1Password**: Password manager
- **System Tools**: Various macOS optimizations and preferences

## Prerequisites

- macOS (Apple Silicon)
- [Nix](https://nixos.org/download.html) with flakes enabled
- [direnv](https://direnv.net/) for automatic environment loading
- [brew](https://brew.sh/) in allow installation via homebrew.

## Installation

1. Install Nix using the [Determinate Systems Installer](https://github.com/DeterminateSystems/nix-installer)

2. Clone this repository:
   ```bash
   git clone https://github.com/hsperker/nix-config.git
   cd nix-config
   ```

3. Allow direnv:
   ```bash
   direnv allow
   ```

4. Apply the configuration:
   ```bash
   nix run nix-darwin -- switch --flake github:hsperker/nix-config
   ```

## Updates

To update your system configuration:
```bash
darwin-rebuild switch --flake ~/src/github.com/hsperker/nix-config
```

## Structure

- `darwin/`: macOS system configuration
- `home-manager/`: User environment configuration
  - `nvim/`: Neovim configuration
  - `starship.nix`: Shell prompt configuration
  - `tmux.nix`: Tmux configuration
- `.config/`: Additional configuration files
- `flake.nix`: Nix flake definition

## Key Bindings

### Window Management (Aerospace)
- `Alt + h/j/k/l`: Focus windows
- `Alt + Shift + h/j/k/l`: Move windows
- `Alt + Ctrl + h/j/k/l`: Join with adjacent window
- `Alt + y`: Tile layout (horizontal/vertical)
- `Alt + t`: Accordion layout (horizontal/vertical)
- `Alt + minus/equal`: Resize window (-/+ 100)
- `Alt + 1/2/3`: Switch workspaces
- `Alt + Shift + 1/2/3`: Move window to workspace
- `Alt + Tab`: Switch between workspaces
- `Alt + Shift + Tab`: Move window to next monitor
- `Alt + Shift + ;`: Enter service mode

### Service Mode
- `Esc`: Return to main mode
- `r`: Flatten workspace tree
- `f`: Toggle floating/tiling layout
- `Backspace`: Close all windows except current

## Open Points

- [ ] Manage dock items
- [ ] Add apps like Alfred to login
- [ ] Configure browser

## Contributing

Feel free to submit issues and pull requests.

## License

This configuration is free to use and modify.
