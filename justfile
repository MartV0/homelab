default:
  just --list

rebuild:
  sudo nixos-rebuild switch --fast --flake "$(pwd)"

up:
  nix flake update

upc:
  nix flake update --commit-lock-file

update-rebuild: upc
  sudo nixos-rebuild switch --fast --flake "$(pwd)"

alias upre := update-rebuild

gc:
  sudo nix-collect-garbage --delete-older-than 30d
