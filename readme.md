```
nix-shell --extra-experimental-features flakes -p git -p just
```
Then 
```
cd ~
git clone git@github.com/MartV0/dotfiles/
git clone git@github.com/MartV0/homelab/ && mv homelab .flake && cd .flake
just rebuild
```

Some additional imperative steps:
- install doom emacs: https://discourse.doomemacs.org/t/installing-doom-emacs-on-nixos/4600
