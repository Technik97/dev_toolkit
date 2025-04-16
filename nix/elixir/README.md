#Elixir Phoenix + PostgreSQL Development Environment

[![Built with Nix](https://img.shields.io/badge/Built_With-Nix-5277C3.svg?logo=nixos)](https://nixos.org)
[![Elixir Version](https://img.shields.io/badge/Elixir-1.16-4B275F.svg?logo=elixir)](https://elixir-lang.org)
[![PostgreSQL Version](https://img.shields.io/badge/PostgreSQL-17-336791.svg?logo=postgresql)](https://www.postgresql.org)

A fully reproducible development environment for Phoenix/Elixir applications with managed PostgreSQL, powered by Nix flakes.

## 📦 Features

- **Pre-configured Services**
  - Phoenix 1.7 development server
  - PostgreSQL 17 with persistent storage
  - Node.js 20 for assets


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
