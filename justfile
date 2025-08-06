default:
  just --list

rebuild:
  sudo nixos-rebuild switch --fast --flake "$(pwd)" --impure

up:
  nix flake update

upc:
  nix flake update --commit-lock-file

update-rebuild: upc
  sudo nixos-rebuild switch --fast --flake "$(pwd)" --impure

alias upre := update-rebuild

gc:
  sudo nix-collect-garbage --delete-older-than 30d

[working-directory: 'services/seafile']
rebuild-seafile-compose: && chown-stuff
  sudo compose2nix --inputs=seafile-server.yml --output=seafile-server-compose.nix --env_files=/run/agenix/seafile-secrets.env,seafile.env --include_env_files=true --env_files_only=true --runtime=docker

chown-stuff:
  sudo chown -R martijn .
  sudo chgrp -R users .

pull-theirs:
  git pull -s recursive -X theirs
