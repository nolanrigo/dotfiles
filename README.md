# Installation on NixOS

## Init submodules

```sh
$ git submodule update --init --recursive
```

## WIP

* Install Git with `nix-env -i git`
* Clone these dotfiles with `git clone "git@github.com:gmarmstrong/dotfiles" "$HOME/dotfiles"`
* Back up system configuration with `sudo mv /etc/nixos /etc/nixos.bak`
* Symlink the system configuration with `sudo ln -s "$HOME/dotfiles/nixos" "/etc"`
* Apply the system configuration with `sudo nixos-rebuild switch`
* Symlink the user configuration with `ln -s "$HOME/dotfiles/nixpkgs/home.nix" "$HOME/.config/nixpkgs/home.nix"`
* Install home-manager with `nix-shell "$HOME/dotfiles/resources/home-manager" -A install`
* Apply the home configuration with `home-manager switch`
