# Zellix
A Simple, [NuShell](https://nushell.sh) Based "Plugin" system for Helix using the power of Zellij!

# What does it do?
Under the hood, it creates a special zellij session, focued on using auto-closing panes to support windows in helix.

# How to use it?
Look at the [example](example), which I use for my daily driver with helix using 
[my dotfile configuration](https://github.com/TheEmeraldBee/PixelNix) with nixos and nix-darwin!

# Creating Plugins
For information on how to create plugins, check out the [wiki](https://github.com/TheEmeraldBee/zellix/wiki)!

# Why does this exist?
At the time of writing this, there is no plugin system for helix, and I dislike the configuration of neovim,
so I created this to satiate my desire for more than just an editor systems that can still be controlled through my editor.

# Contributing
At this time, the [example](example) directory is not accepting pull requests,
as it is my personal usage of this system. But the core itself is welcome to changes to support more custom systems, as well
as eventually gaining some form of library to better support easier creation of plugins!

# WARNING
At this time, this is a very rough implementation that hasn't been fully tested. 
If you choose to use this, please report **any** bugs you find during usage, and I will fix them ASAP.
