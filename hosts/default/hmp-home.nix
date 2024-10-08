{ config, pkgs, pkgs-unstable, ... }:

{
  imports = [
    ../../modules/home-manager/shell/zsh.nix
    ../../modules/home-manager/wm/sway.nix
    ../../modules/home-manager/music/spicetify.nix
    ../../modules/home-manager/scripts
    ../../modules/home-manager/editors/emacs
    ../../modules/home-manager/theming/stylix
    ../../modules/home-manager/screenrecord/obs
    ../../modules/home-manager/audio/easyeffects
    ../../modules/home-manager/music/mpd.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "hmp";
  home.homeDirectory = "/home/hmp";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    (texlive.combine {
      inherit (texlive)
        scheme-medium dvisvgm dvipng # for preview and export as html
        wrapfig amsmath ulem hyperref capt-of;
      #(setq org-latex-compiler "lualatex")
      #(setq org-preview-latex-default-process 'dvisvgm)
    })

    starship
    pstree
    vesktop
    emacsPackages.vterm
    ytfzf
    ispell
    sioyek
    calibre
    nixfmt-classic
    playerctl
    mpd
    mpc-cli
    librewolf
    fastfetch
    gnome.gnome-clocks
    cava
    wl-color-picker
    swaybg
    ripgrep
    variety
    pamixer
    komikku
    hakuneko
    cliphist
    distrobox
    telegram-desktop
    signal-desktop
    drm_info
    jq
    audacity
    # davinci-resolve
    pavucontrol
    libsForQt5.kdenlive
    gimp
    mediainfo
    glaxnimate
    easyeffects
    subtitleedit
    pandoc
    cowsay
    okular
    transmission-gtk
    zstd
    pyright
    nodePackages.typescript-language-server
    typescript
    dockerfile-language-server-nodejs
    nodePackages.prettier
    nodejs
    brave
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/hmp/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    HISTFILE = "${config.home.homeDirectory}/.histfile";
    HISTSIZE = 1000;
    MPD_HOST = "localhost";
    TERMINAL = "foot";
    BROWSER = "firefox";
    BROWSER2 = "brave";
    WALLPAPERS_SRC = "${config.home.homeDirectory}/.config/variety/Favorites/.";
  };

  zsh.enable = true;
  sway.enable = true;
  emacs.enable = true;
  stylix.enable = true;
  easyeffects.enable = true;
  spicetify.enable = true;
  mpd.enable = true;
  obs.enable = true;
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
