#!/bin/bash

# install-docker-almalinux.sh
# Tested on AlmaLinux 8.x and 9.x

set -e

echo "🔧 Starting Docker and tools installation on AlmaLinux..."

# Ensure script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "❌ Please run this script as root or with sudo."
  exit 1
fi

# Detect AlmaLinux version
ALMA_VERSION=$(rpm -E %{rhel})
echo "➡ Detected AlmaLinux version: $ALMA_VERSION"

# Update system
echo "📦 Updating system..."
dnf update -y

# Install basic tools
echo "📥 Installing curl, git, nano..."
dnf install -y curl git nano

# Install Docker dependencies
echo "🔌 Installing Docker dependencies..."
dnf install -y dnf-plugins-core

# Add Docker repo
echo "📦 Adding Docker CE repository..."
dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# Install Docker & Compose Plugin
echo "🐳 Installing Docker Engine and Docker Compose plugin..."
dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Enable and start Docker service
echo "🚀 Enabling and starting Docker service..."
systemctl enable docker
systemctl start docker

# Verify Docker installation
echo "✅ Verifying Docker installation..."
docker --version && docker compose version

echo ""
echo "🎉 Docker, Docker Compose, curl, git, and nano installed successfully on AlmaLinux $ALMA_VERSION!"
echo "👉 You can now use Docker. Optionally, add your user to the docker group:"
echo "   sudo usermod -aG docker \$USER && newgrp docker"
