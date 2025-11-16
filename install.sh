#!/usr/bin/env bash
# mason-deps.sh — Install packages needed for Mason LSP servers on Ubuntu/WSL

set -euo pipefail

echo "[*] Updating package lists..."
sudo apt update -y

echo "[*] Installing base developer tools..."
sudo apt install -y \
  build-essential \
  curl git unzip tar xz-utils

echo "[*] Installing Node.js + npm (for JS-based language servers)..."
sudo apt install -y nodejs npm

echo "[*] Installing Python 3 environment and headers..."
sudo apt install -y python3 python3-pip python3-venv python3-dev

echo "[*] Installing useful CLI tools for Neovim integrations..."
sudo apt install -y ripgrep fd-find

echo "[*] Cleaning up..."
sudo apt autoremove -y
sudo apt clean

echo
echo "[✔] System dependencies for Mason/Nvim LSPs installed successfully!"
echo "You can now re-open Neovim and run :MasonInstall to finish plugin setup."

