default:
  just --list

rebuild:
  sudo nixos-rebuild switch --fast --flake "$(pwd)"

up:
  nix flake update

up-repo: up
  git add flake.lock
  git commit -m "updated lock file to revision $(nixos-version)"

gc:
  sudo nix-collect-garbage --delete-older-than 30d
