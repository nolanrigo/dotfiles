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

# Update manually the channel

I wished, I could just update the `stateVersion` and run `nrs`
but it seems that we need to update the channel manually to perform the update.

```sh
$ sudo nix-channel --add https://nixos.org/channels/nixos-20.03 nixos
$ sudo nix-channel --update
```

# Apply the update on the computer

```sh
$ nrs --upgrade
```

Restart the computer and rebuild the `home-manager`

```sh
$ hms
```

