# Upgrade to the latest nixos channel

[What is a channel](https://nixos.wiki/wiki/Nix_channels)

# What's the last channel available ?

You can see the status of the different channels on the <https://status.nixos.org/>

# Edit `nixos/params.nix`

Change the `nixos.version` with the new channel number


```diff
  nixos = {
-   version = "20.03";
+   version = "20.09";
  };
```

# Update the channel manually

I wished, I could just update the `stateVersion` and run `nrs`
but it seems that we need to update the channel manually to perform the update.

```sh
$ sudo nix-channel --add https://nixos.org/channels/nixos-20.09 nixos
$ sudo nix-channel --update
```

# Apply the update on the computer

```sh
$ nrsu
```

Restart the computer

```sh
$ reboot
```
