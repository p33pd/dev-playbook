#!/bin/bash

set -euo pipefail

VENV_DIR=".venv"

echo "Starting workstation setup..."

# System deps Ansible's dnf module needs on Fedora
echo "Ensuring system Python deps..."
sudo dnf install -y python3 python3-pip python3-libdnf5

# Create venv if missing
if [[ ! -d "$VENV_DIR" ]]; then
    echo "Creating Python venv at $VENV_DIR..."
    # --system-site-packages lets the venv import python3-libdnf5 (not on PyPI)
    python3 -m venv --system-site-packages "$VENV_DIR"
fi

# shellcheck disable=SC1091
source "$VENV_DIR/bin/activate"

echo "Upgrading pip & installing Ansible..."
pip install --upgrade pip
pip install ansible ansible-lint

# Install Galaxy collections
if [[ -s requirements.yml ]]; then
    echo "Installing Ansible Galaxy requirements..."
    ansible-galaxy install -r requirements.yml
fi

echo "Linting playbook..."
ansible-lint main.yml || true

echo "Running Ansible playbook..."
ansible-playbook main.yml --ask-become-pass
