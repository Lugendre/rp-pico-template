{
  description = "Rust development environment for Raspberry Pi Pico";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    claude-code.url = "github:sadjow/claude-code-nix";
  };

  outputs = { self, nixpkgs, flake-utils, rust-overlay, claude-code }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = { allowUnfree = true; };
          overlays =
            [ rust-overlay.overlays.default claude-code.overlays.default ];
        };
      in {
        devShells.default = pkgs.callPackage ./shell.nix { };

        packages.default = pkgs.rustPlatform.buildRustPackage {
          pname = "rp-pico-template";
          version = "0.1.0";
          src = ./.;
          cargoLock.lockFile = ./Cargo.lock;

          # Cross-compilation for ARM Cortex-M0+
          CARGO_BUILD_TARGET = "thumbv6m-none-eabi";
          RUSTFLAGS = "-C link-arg=-Tlink.x";

          # Skip tests for cross-compilation
          doCheck = false;

          nativeBuildInputs = with pkgs; [
            rust-bin.stable.latest.default.override
            {
              extensions = [ "rust-src" ];
              targets = [ "thumbv6m-none-eabi" ];
            }
            flip-link
          ];
        };

        templates.default = {
          path = ./.;
          description = "Rust development template for Raspberry Pi Pico";
        };
      });
}
