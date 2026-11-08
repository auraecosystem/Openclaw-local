git clone https://github.com/openclaw/openclaw.git
cd openclaw

pnpm install
pnpm ui:build # auto-installs UI deps on first run
pnpm build

pnpm openclaw onboard --install-daemon

# Dev loop (auto-reload on TS changes)
pnpm gateway:watch
# Enable flakes
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf

# Enter environment
nix develop

# Run app
nix run

# Build package
nix build

# Update dependencies
nix flake update
git clone https://github.com/auraecosystem/clawapp.git
cd clawapp
echo 'PROXY_TOKEN=your-token' > .env
echo 'OPENCLAW_GATEWAY_TOKEN=your-gw-token' >> .env
# Or use password auth: echo 'OPENCLAW_GATEWAY_PASSWORD=your-gw-password' >> .env
docker compose up -d --build
