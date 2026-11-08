git clone https://github.com/auraecosystem/clawdbot-d08.git
cd clawdbot-d08
https://github.com/auraecosystem/Openclaw-local.git
cd Openclaw-local
pnpm install

# First run only (or after resetting local OpenClaw config/workspace)
pnpm openclaw setup

# Optional: prebuild Control UI before first startup
pnpm ui:build

# Dev loop (auto-reload on source/config changes)
pnpm gateway:watch
