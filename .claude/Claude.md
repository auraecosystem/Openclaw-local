I want to set up nix-openclaw on my machine (Apple Silicon macOS or x86_64 Linux).

Repository: github:openclaw/nix-openclaw

What nix-openclaw is:
- Batteries-included Nix package for OpenClaw (AI assistant gateway)
- Installs the gateway everywhere; macOS app only on macOS
- Runs as a launchd service on macOS, systemd user service on Linux

What I need you to do:
1. Inspect my OS, CPU architecture, shell, Home Manager setup, and whether Nix with flakes is installed
2. Ask me only for missing choices: channel, bot/account secrets, allowed users, provider keys, and documents/identity preferences
3. Create a local flake at ~/code/openclaw-local using templates/agent-first/flake.nix
4. Create a docs dir next to the config (e.g., ~/code/openclaw-local/documents) with AGENTS.md, SOUL.md, TOOLS.md (optional: IDENTITY.md, USER.md, LORE.md, HEARTBEAT.md, PROMPTING-EXAMPLES.md)
   - If ~/.openclaw/workspace already has these files, adopt them into the documents dir first (use copy/rsync that dereferences symlinks, e.g. `cp -L`)
5. Help me create or connect the channel account I choose
6. Set up secrets (bot token, provider key) - plain files at ~/.secrets/ are fine unless I already have a secret manager
7. Ask whether I want local memory through QMD; if yes, set `memory.backend = "qmd"` in OpenClaw config
8. Fill in the template placeholders and run home-manager switch
9. Verify end-to-end: package builds, service is running, gateway health works, QMD works if enabled, and the bot/channel responds if configured

My setup:
- OS: [macOS / Linux]
- CPU: [arm64 / x86_64]
- System: [aarch64-darwin / x86_64-linux]
- Home Manager config name: [FILL IN or "I don't have Home Manager yet"]

Reference the README and templates/agent-first/flake.nix in the repo for the module options.
