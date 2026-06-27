{ config, pkgs, pkgs-unstable, lib, ... }:

{
  imports = [
    ../../modules/home-manager/shell/zsh.nix
    ../../modules/home-manager/shell/direnv.nix
    ../../modules/home-manager/wm/sway.nix
    ../../modules/home-manager/music/spicetify.nix
    ../../modules/home-manager/scripts
    ../../modules/home-manager/editors/emacs
    ../../modules/home-manager/theming/stylix
    ../../modules/home-manager/screenrecord/obs
    ../../modules/home-manager/audio/easyeffects
    ../../modules/home-manager/music/mpd.nix
    ../../modules/home-manager/terminal/foot.nix
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
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs;
    ([
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
          wrapfig amsmath ulem hyperref capt-of biber biblatex biblatex-mla
          sectsty;
        #(setq org-latex-compiler "lualatex")
        #(setq org-preview-latex-default-process 'dvisvgm)
      })

      starship
      emacsPackages.vterm
      ispell
      calibre
      nixfmt-classic
      playerctl
      mpd
      mpc
      fastfetch
      cava
      wl-color-picker
      swaybg
      ripgrep
      variety
      pamixer
      cliphist
      drm_info
      jq
      audacity
      # davinci-resolve
      pavucontrol
      kdePackages.kdenlive
      frei0r
      gimp
      mediainfo
      pandoc
      kdePackages.okular
      zstd
      pyright
      nodePackages.typescript-language-server
      typescript
      dockerfile-language-server
      nodePackages.prettier
      nodejs
      brave
      ani-cli
      prismlauncher
      # (discord.override {
      #   withVencord = true; # can do this here too
      # })
      discord
      aria2
      unrar
      # (pkgs.callPackage ../../modules/home-manager/lsp/luau-lsp.nix { })
      # (pkgs.callPackage ../../modules/home-manager/roblox/wally.nix { })
      gdb
      sdl3
      pkg-config
      cmake-language-server
      glsl_analyzer
      libnotify
      libreoffice-qt
      kotatogram-desktop
      thunderbird
      steam-run
      sioyek
      tokei
      gnuplot
      mermaid-cli
      blender
      plantuml
      tree
    ]) ++ (with pkgs-unstable; [ code-cursor ]);

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
  foot.enable = true;
  sway.enable = true;
  emacs.enable = true;
  stylix.enable = true;
  easyeffects.enable = false;
  spicetify.enable = true;
  mpd.enable = true;
  obs.enable = true;
  direnv.enable = true;

  dconf.settings = {
    "org/gnome/desktop/interface" = { color-scheme = "prefer-dark"; };
  };

  sops.age.keyFile = "/home/hmp/.config/sops/age/keys.txt";

  # sops.secrets.spotify-password.sopsFile = ../../secrets/spotify.yaml;
  # sops.secrets.spotify-username.sopsFile = ../../secrets/spotify.yaml;

  # sops.templates."spotifyd.conf" = {
  #   content = ''
  #     [global]
  #     username = "${config.sops.placeholder.spotify-username}"
  #     password = "${config.sops.placeholder.spotify-password}"
  #     device_name = "Aurelius"
  #     backend = "pulseaudio"
  #     volume_controller = "softvol"
  #   '';
  # };

  #   systemd.user.services.spotifyd = {
  #     Unit = { After = [ "sops-nix.service" ]; };
  #     Service = {
  #       ExecStart = lib.mkForce
  #         "${pkgs.spotifyd}/bin/spotifyd --no-daemon --config-path ${
  #           config.sops.templates."spotifyd.conf".path
  #         }";
  #     };
  #     Install.WantedBy = [ "default.target" ];
  #   };

  programs.spotify-player.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
