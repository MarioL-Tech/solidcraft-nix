# SolidCraft for Nix

An unofficial Nix wrapper for the upstream SolidCraft 0.45.0 Linux AppImage. It downloads the release and verifies its pinned SHA-256; it does not build the application from source or bundle the AppImage in this repository.

## Requirements and use

Requires Nix with flakes enabled and x86_64 Linux. From a checkout:

```sh
nix build path:.#solidcraft
nix run path:.#solidcraft
```

`path:.` includes untracked files, which matters in a new Git checkout; ordinary Git flake references only include tracked files. Review files before adding them to Git. Network access may be needed to fetch nixpkgs, the AppImage, and build dependencies. The result includes a desktop entry and runs `solidcraft`.

## NixOS module

Add this repository as a flake input (replace the URL with your published repository or an absolute `path:` URL), then import and enable its module:

```nix
# In flake.nix
inputs.solidcraft.url = "github:OWNER/solidcraft-nix";
# In your nixosSystem modules list:
# inputs.solidcraft.nixosModules.default
```

```nix
# In a NixOS module
programs.solidcraft.enable = true;
```

The module is disabled by default and uses the host's `pkgs`, not this flake's pinned nixpkgs. It installs system-wide; it does not configure the application. The standalone package uses the nixpkgs revision in `flake.lock`. Update that pin deliberately with `nix flake update nixpkgs` and test before deployment.

## Licensing and limitations

Upstream: [SolidCraft](https://github.com/tangency-labs/solidcraft), [v0.45.0 release](https://github.com/tangency-labs/solidcraft/releases/tag/v0.45.0). The package metadata identifies the application license as Apache-2.0; consult upstream for its license, notices, bundled components, and any separate terms. This repository does not grant rights to upstream assets. Only the x86_64 Linux binary is packaged; upstream availability and runtime behavior are not guaranteed. This is an independent packaging project, not an upstream release.
