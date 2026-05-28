{
  description = "Web4 / LMLM Agent Template";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";

    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    rust-overlay,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;

          overlays = [
            (import rust-overlay)
          ];

          config.allowUnfree = true;
        };

        python = pkgs.python311.withPackages (ps:
          with ps; [
            fastapi
            uvicorn
            pydantic
            requests
            websockets
            aiohttp
            rich
            typer
            openai
            numpy
          ]);

      in
      {
        devShells.default = pkgs.mkShell {

          buildInputs = with pkgs; [

            # Core
            git
            curl
            wget
            jq

            # Node Runtime
            nodejs_22
            bun
            pnpm

            # Python AI Runtime
            python

            # Rust
            rust-bin.stable.latest.default
            cargo

            # Go
            go
            gopls

            # Containers
            docker
            docker-compose

            # Build Tools
            gcc
            cmake
            pkg-config

            # Crypto / TLS
            openssl

            # SQLite
            sqlite

            # Utilities
            tree
            htop
          ];

          shellHook = ''
            echo ""
            echo "🤖 Web4 Agent Runtime"
            echo "⚡ LMLM Agent Template Ready"
            echo ""

            export AGENT_ENV=development
            export PYTHONUNBUFFERED=1
            export NODE_ENV=development

            export AGENT_NAME="web4-agent"

            alias ll="ls -la"
            alias gs="git status"
            alias serve="python -m http.server 8080"

            mkdir -p .agent
            mkdir -p logs
            mkdir -p runtime
          '';
        };

        packages.default = pkgs.stdenv.mkDerivation {
          pname = "web4-agent";
          version = "0.1.0";

          src = ./.;

          buildPhase = ''
            echo "Building Web4 Agent..."
          '';

          installPhase = ''
            mkdir -p $out
            cp -r . $out/
          '';
        };

        apps.default = {
          type = "app";

          program = "${pkgs.writeShellScript "run-agent" ''
            echo "Starting Web4 Agent..."

            if [ -f main.py ]; then
              python main.py

            elif [ -f server.py ]; then
              python server.py

            elif [ -f index.js ]; then
              node index.js

            elif [ -f main.rs ]; then
              cargo run

            else
              echo "No entrypoint found."
            fi
          ''}";
        };
      });
}
