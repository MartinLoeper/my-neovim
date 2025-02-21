# my-neovim

This repsitory contains my neovim config and all tools required to run it such as lsps and formatters.
It is shipped as a home manager config. Thus, I can install it into devcontainers using dotfiles and devbox.
TBD: install steps

This config is also installed into my NixOS. No code duplication. :)
TBD: install steps

## Create the container

```bash
devcontainer up --workspace-folder . --dotfiles-repository https://github.com/MartinLoeper/my-neovim"
```

## Start neovim

```bash
docker exec --user vscode -it <containerId> zsh -i -c "cd ~/dotfiles && nvim ."
```
