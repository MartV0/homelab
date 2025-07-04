```
nix-shell --extra-experimental-features flakes -p git -p just
```
Then 
```
git clone git@github.com/MartV0/homelab/ && mv homelab .flake && cd .flake
just rebuild
```
