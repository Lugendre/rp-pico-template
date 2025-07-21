{ pkgs, ... }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    # Rust toolchain with embedded target
    (rust-bin.stable.latest.default.override {
      extensions = [ "rust-src" "rustfmt" "clippy" "rust-analyzer" ];
      targets = [ "thumbv6m-none-eabi" ];
    })

    # Embedded development tools
    probe-rs-tools
    elf2uf2-rs
    flip-link

    # Debugging tools
    gdb
    openocd

    # Development utilities
    cargo-binutils
    cargo-expand
    cargo-nextest
    cargo-watch
    claude-code
    less
    openssl

    # System tools
    pkg-config
    udev
  ];

  shellHook = ''
    exec zsh
  '';

  RUST_SRC_PATH =
    "${pkgs.rust-bin.stable.latest.rust-src}/lib/rustlib/src/rust/library";
}
