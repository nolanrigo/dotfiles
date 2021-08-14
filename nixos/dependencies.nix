with import <nixpkgs> {};

{
  home-manager = version: fetchFromGitHub {
    name = "home-manager";
    owner = "nix-community";
    repo = "home-manager";
    rev = "release-${version}";
    sha256 = "0xw1vgwfdn75rgamcsi5j1iqfl0j06x8xp92k24wr9hayfr5m400";
  };
  nixos-hardware = fetchFromGitHub {
    name = "nixos-hardware";
    owner = "NixOS";
    repo = "nixos-hardware";
    rev = "master"; # 7da029f26849f8696ac49652312c9171bf9eb170
    sha256 = "0qcsjvjq9wcdy6jfnp4299ng2497g8kk2gh85jxr5zij9v6jl7pr";
  };
  base16-i3 = fetchFromGitHub {
    name = "base16-i3";
    owner = "khamer";
    repo = "base16-i3";
    rev = "master"; # 78292138812a3f88c3fc4794f615f5b36b0b6d7c";
    sha256 = "1ikhywvf6gzyw6win07rzn0zna5bl516gpvkfrr4lfq25xh3vy4x";
  };
  base16-xresources = fetchFromGitHub {
    name = "base16-xresources";
    owner = "base16-templates";
    repo = "base16-xresources";
    rev = "master"; # 79e6e1de591f7444793fd8ed38b67ce7fce25ab6";
    sha256 = "1nnj5py5n0m8rkq3ic01wzyzkgl3g9a8q5dc5pcgj3qr47hhddbw";
  };
  base16-qutebrowser = fetchFromGitHub {
    name = "base16-qutebrowser";
    owner = "theova";
    repo = "base16-qutebrowser";
    rev = "main"; # 67453c938c2c47633c652172b27b5b8abf218142
    sha256 = "0rwsphq77l6v15gz4pzyv2zzwg5wnm80qzcccn0nwwnhm6nrv4ak";
  };
  base16-textmate = fetchFromGitHub {
    name = "base16-textmate";
    owner = "chriskempson";
    repo = "base16-textmate";
    rev = "master"; # 1d9e52afb74e03f5a2fdc53d9327428fe00c70c7";
    sha256 = "1h10ynqdrnh9xh9pxjzrd2yk85zavmmqs9mx6hb2v0dq4m81hkmr";
  };
  base16-zathura = fetchFromGitHub {
    name = "base16-zathura";
    owner = "HaoZeke";
    repo = "base16-zathura";
    rev = "main"; # d97b110bf6d576cd2c09e45cdf27d44f4e0af87b
    sha256 = "1q0x2y0dzshrghd5f5b2gzc5bd538v60b1wd2xn8gfs71vx1v6wc";
  };
  base16-rofi = fetchFromGitHub {
    name = "base16-rofi";
    owner = "0xdec";
    repo = "base16-rofi";
    rev = "master"; # afbc4b22d8f415dc89f36ee509ac35fb161c6df4";
    sha256 = "1f9gkfc4icdgdj0fkkgg1fw3n6imlr1sbi42qm9hbkjxy5fmzay2";
  };
  rofi-emoji = fetchFromGitHub {
    name = "rofiemoji";
    owner = "nkoehring";
    repo = "rofiemoji";
    rev = "master"; # ad61572830c9d3c00e30eec078d46dad3cfdb4a2";
    sha256 = "16rhb2cs8cqwflkcyw5dr77alp5wik4bv1dg66m4hkgcplxv0dx0";
  };
  polybar-pulseaudio-control = fetchFromGitHub {
    name = "polybar-pulseaudio-control";
    owner = "marioortizmanero";
    repo = "polybar-pulseaudio-control";
    rev = "master"; # d961976ebf0564ac2c321a30406f1e080fb1b206
    sha256 = "0mmd1j1nzp69b0b59npdmpcjsaf2kgg85hh4m1xr7af026mblvh9";
  };
}
