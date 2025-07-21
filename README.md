# Raspberry Pi Pico Rust Template

A Nix flake template for developing Rust applications on the Raspberry Pi Pico microcontroller.

## Features

- Rust development environment with cross-compilation support
- Target: `thumbv6m-none-eabi` (ARM Cortex-M0+)
- Pre-configured with necessary tools and dependencies
- Nix flake for reproducible development environment

## Usage

### Using as a template

Create a new project using this template:

```bash
nix flake init -t github:Lugendre/rp-pico-template
```

Or specify the template explicitly:

```bash
nix flake new my-pico-project -t github:Lugendre/rp-pico-template
```

### Development

Enter the development shell:

```bash
nix develop
```

Build the project:

```bash
cargo build --release
```

### Flashing to Pico

1. Hold the BOOTSEL button while connecting the Pico to your computer
2. Copy the generated `.uf2` file to the mounted Pico drive

## Requirements

- Nix with flakes enabled
- Raspberry Pi Pico hardware

## Project Structure

- `src/main.rs` - Main Rust source code
- `Cargo.toml` - Rust package configuration
- `memory.x` - Memory layout for the Pico
- `flake.nix` - Nix flake configuration
- `shell.nix` - Development shell definition
