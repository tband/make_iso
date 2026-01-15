# 1. Install our official public software signing key:
wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > /usr/share/keyrings/signal-desktop-keyring.gpg

# 2. Add our repository to your list of repositories:
wget -O- https://updates.signal.org/static/desktop/apt/signal-desktop.sources > /etc/apt/sources.list.d/signal-desktop.sources

# 3. Update your package database and install Signal:
apt update && apt install signal-desktop
