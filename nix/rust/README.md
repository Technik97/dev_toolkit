# Rust Development Environment

[![Built with Nix](https://img.shields.io/badge/Built_With-Nix-5277C3.svg?logo=nixos)](https://nixos.org)
[![Rust Version](https://img.shields.io/badge/Rust-Beta-orange.svg?logo=rust)](https://rust-lang.org)
[![Rust Analyzer](https://img.shields.io/badge/Rust_Analyzer-Latest-blue.svg)](https://rust-analyzer.github.io)

A reproducible Rust development environment powered by Nix flakes, featuring the latest Rust beta toolchain and essential development tools.

## ✨ Features

- **Latest Rust Beta Toolchain**
- **Pre-configured Components**:
  - `rustc` compiler
  - `cargo` package manager
  - `rust-analyzer` LSP
  - `gcc` toolchain for native dependencies

- **Automatic Environment Setup**:
  - Version check on shell entry
  - Clean environment isolation

## 🚀 Quick Start

### Prerequisites

#### For NixOS Users:
```bash
# Ensure these are in your configuration.nix
environment.systemPackages = [
  git
];

# Enable flakes permanently
nix.settings.experimental-features = [ "nix-command" "flakes" ];

#### For non NixOS Users:
- [Nix](https://nixos.org/download.html) installed
- Flakes enabled (add to `~/.config/nix/nix.conf`):
  ```ini
  experimental-features = nix-command flakes
