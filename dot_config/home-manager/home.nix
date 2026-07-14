{ config, pkgs, ... }:

{
  home.username = "thadryan";
  home.homeDirectory = "/home/thadryan";
  home.stateVersion = "25.11"; # Please read the comment before changing.
  targets.genericLinux.enable = true;
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [

    ## on deb but would be older than my config is set for
    neovim
    # kitty
    # stow
    # vim-full
    # tmux
    # tmuxinator
    # fzf
    # atuin
    # tree
    # ripgrep
    # silver-searcher
    # fd
    # bat
    # zoxide
    # cargo

    # megasync <- this had to get scripted but is officially supported
    # not on deb
    watchexec
    diffnav
    yazi
    pixi
    (vivaldi.override {
    	proprietaryCodecs = true;
    	enableWidevine = true;
    })
    discord
    spotify
    ferdium
    zotero

  ];

  home.file = { };
  home.sessionVariables = {
    # EDITOR = "emacs";
    EDITOR = "vim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
