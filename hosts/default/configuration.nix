# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, pkgs-unstable, inputs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    inputs.stylix.nixosModules.stylix
    ../../modules/nixos/stylix
  ];

  boot = {
    plymouth.enable = true;
    loader = {
      efi = { canTouchEfiVariables = true; };
      grub = {
        enable = true;
        useOSProber = true;
        copyKernels = true;
        efiSupport = true;
        fsIdentifier = "label";
        #efiInstallAsRemovable = true; # in case canTouchEfiVariables doesn't work for your system
        device = "nodev";
        extraEntries = ''
          menuentry "Reboot" {
              reboot
          }
          menuentry "Poweroff" {
              halt
          }
        '';
      };
    };

    # Enable "Silent Boot"
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];

    # Hide the OS choice for bootloaders.
    # It's still possible to open the bootloader list by pressing any key
    # It will just not appear on screen unless a key is pressed
    loader.timeout = 0;
  };

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [ rocmPackages.clr.icd ];
  };

  networking.hostName = "Aurelius"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable =
    true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-gtk # alternatively, kdePackages.fcitx5-qt
      libsForQt5.fcitx5-unikey
      fcitx5-configtool
      fcitx5-unikey
    ];
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = [ pkgs.brlaser ];
  };
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  virtualisation.docker.enable = false;
  virtualisation.docker.daemon.settings = {
    data-root = "/home/hmp/.local/share/docker-root";
  };
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Enable flatpak
  services.flatpak.enable = true;

  # Allow unfree
  nixpkgs.config.allowUnfree = true;

  # Allow experimental nix command
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.hmp = {
    isNormalUser = true;
    home = "/home/hmp";
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs;
      inherit pkgs-unstable;
    };
    backupFileExtension = "hm-backup";
    users = { "hmp" = import ./hmp-home.nix; };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    zsh
    ventoy
    tmux
    pulseaudio
    gnome.gnome-keyring
    jetbrains-mono
    dejavu_fonts
    font-awesome_5
    cmake
    gnumake
    clang
    fd
    auto-cpufreq
    wget
    libgcc
    coreutils
    htop
    firefox
    ffmpeg-full
    vulkan-tools
    swaylock-effects
    wlsunset
    fcitx5
    xdg-utils
    wofi
    imv
    mako
    wob
    sov
    mpv
    polkit
    unzip
    virt-manager
    wl-clipboard
    git
    keepassxc
    alacritty
    wezterm
    foot
    libvterm
    i3status
    wlr-randr
    xorg.xeyes
    grim
    slurp
    satty
    xfce.thunar
    killall
    waon
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  services.auto-cpufreq.enable = true;

  services.gnome.gnome-keyring.enable = true;
  services.displayManager.sessionPackages = [ pkgs.sway ];

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.sugarCandyNix = {
    enable = true; # This set SDDM's theme to "sddm-sugar-candy-nix".
    settings = {
      # Set your configuration options here.
      # Here is a simple example:
      Background = lib.cleanSource ../../shared/Images/Gate.jpg;
      ScreenWidth = 1920;
      ScreenHeight = 1080;
      FormPosition = "left";
      HaveFormBackground = true;
      PartialBlur = true;
    };
  };

  programs.zsh.enable = true;
  programs.sway.enable = true;
  programs.sway.wrapperFeatures.gtk = true;

  services.xserver.enable = true;
  services.xserver.autorun = false;
  services.xserver.displayManager.startx.enable = true;
  services.xserver.windowManager.dwm.enable = true;
  services.xserver.windowManager.dwm.package =
    pkgs.dwm.overrideAttrs { src = /home/hmp/.local/src/dwm-2; };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  security.polkit.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

}
