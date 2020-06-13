# Upgrade to the latest nixos channel

[What is a channel](https://nixos.wiki/wiki/Nix_channels)

# Which is the last channel number ?

You can see the status of the different channels on the [Nixos Channel Status](https://status.nixos.org/)

# Edit `~/dotfiles/nixos/configuration.nix`

Change the `stateVersion` with the new channel number


```diff
- stateVersion = "19.09";
+ stateVersion = "20.03";
```

# Apply the update on the computer

```sh
$ nrs --upgrade
```

Restart the computer and rebuild the `home-manager`

```sh
$ hms
```

