FROM mcr.microsoft.com/devcontainers/base:resolute

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update \
    && apt-get install -y --no-install-recommends vim \
    && rm -rf /var/lib/apt/lists/*

USER vscode

# The original devcontainer supplies Homebrew through a feature. Install it here
# so this Dockerfile also works when used without that feature.
RUN NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
ENV PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:${PATH}"

ENV VISUAL="code --wait"
ENV EDITOR="code --wait"
ENV TZ=Asia/Tokyo

RUN brew install glab eksctl git-secrets \
    && git secrets --register-aws --global \
    && git secrets --install /home/vscode/.git-templates/git-secrets \
    && git config --global init.templatedir '~/.git-templates/git-secrets'

ARG GIT_USER_NAME
ARG GIT_USER_EMAIL

RUN git config --global user.name "$GIT_USER_NAME" \
    && git config --global user.email "$GIT_USER_EMAIL"

USER root

RUN arch="$(dpkg --print-architecture)" \
    && curl -fsSL "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_${arch}/session-manager-plugin.deb" \
       -o /tmp/session-manager-plugin.deb \
    && dpkg -i /tmp/session-manager-plugin.deb \
    && rm /tmp/session-manager-plugin.deb

USER vscode

RUN CODEX_NON_INTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://chatgpt.com/codex/install.sh)"
