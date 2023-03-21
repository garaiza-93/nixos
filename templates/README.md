# Templates, templates, templates

You may noticed that I don't have any language servers in my neovim configuration. I use project local settings in conjunction with devshells to do so. Just using the magic of Nix.

### Each template has
- A devshell that provides a language server and dependencies
- Local neovim settings, typically for LSP

I may iterate on these as I keep practicing.

### Using templates

You can alias these templates to a registry using `nix registry add`
For example, I keep all this repo in `~/.config/nixos`
```
nix registry add frostedflakes ~/.config/nixos/templates
```

Then, init a flake using the template. Example:
```
nix flake init -t frostedflakes#nodets
```
This will copy the contents of `nodets/` to the current directory where you used the command.
