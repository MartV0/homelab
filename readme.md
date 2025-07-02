```
nix-shell --extra-experimental-features flakes -p git -p just
```
Then 
```
git clone https://github.com/MartV0/homelab/ && mv homelab .flake && cd .flake
just rebuild
```
