#!/bin/bash
set -e

echo "Setting up development environment..."

# NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"' >> $HOME/.bashrc
# eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"

brew install glab eksctl tfenv git-secrets

# AWS SSM Session Manager Plugin
curl -fsSL "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_arm64/session-manager-plugin.deb" \
  -o /tmp/session-manager-plugin.deb
sudo dpkg -i /tmp/session-manager-plugin.deb
rm /tmp/session-manager-plugin.deb

git secrets --register-aws --global
git secrets --install ~/.git-templates/git-secrets
git config --global init.templatedir '~/.git-templates/git-secrets'
git config --global user.name "$GIT_USER_NAME"
git config --global user.email "$GIT_USER_EMAIL"

CODEX_NON_INTERACTIVE=1 \
  /bin/bash -c "$(curl -fsSL https://chatgpt.com/codex/install.sh)"