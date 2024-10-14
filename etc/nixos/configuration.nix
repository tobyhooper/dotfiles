{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # hostname
  networking.hostName = "ideapad305";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Enable Wayland
  services.displayManager.sddm.wayland.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "uk";

  # Enable CUPS to print documents.
  services.printing.enable = false;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  
  # enable zsh
  programs.zsh.enable = true;

  # user account
  users.users.toby = {
    isNormalUser = true;
    description = "Toby Hooper";
    extraGroups = [ "networkmanager" "wheel" "vboxusers" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
    ];
  };

  # set nix-shell to use zsh as default
  environment.variables.SHELL = "${pkgs.zsh}/bin/zsh";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # software to install
  environment.systemPackages = with pkgs; [
  pkgs.home-manager
  neovim
  brave
  neofetch
  steam
  discord
  lua51Packages.lua
  lua51Packages.luarocks-nix
  cargo
  nodejs_22
  vscode
  jetbrains-toolbox
  python312Packages.python
  python312Packages.pip
  zsh
  git
  libgcc
  gcc
  gnumake
  meslo-lgs-nf
  spotify
  htop
  alacritty
  virtualbox
  bitwarden-desktop
  ];

  #virtualbox setup (kernel modules)
  boot.kernelPackages = pkgs.linuxPackages_latest;
  virtualisation.virtualbox.host.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  # nix garbage collector
  systemd.timers.nix-garbage-collect = {
    enable = true;
    timerConfig.onCalendar = "daily";
    timerConfig.persistent = true;
    unitConfig.ExecStart = "${pkgs.nix}/bin/nix-collect-garbage --delete-older-than 1d";
  };

}
