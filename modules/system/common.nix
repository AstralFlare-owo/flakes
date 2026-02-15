{ pkgs, ... }: {
  boot.loader.systemd-boot.enable = true;

  networking.networkmanager.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
  ];

  services.openssh.enable = true;
  services.flatpak.enable = true;
  services.xserver.excludePackages = [ pkgs.xterm ];
  programs.zsh.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
  services.gnome.gnome-keyring.enable = true;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      zlib
      zstd
      stdenv.cc.cc
      curl
      openssl
      attr
      libssh
      bzip2
      libxml2
      acl
      libsodium
      util-linux
      xz
      systemd
      xorg.libXcomposite
      xorg.libXtst
      xorg.libXrandr
      xorg.libXext
      xorg.libX11
      xorg.libXfixes
      libGL
      libva
      pipewire
      xorg.libxcb
      xorg.libXdamage
      xorg.libxshmfence
      xorg.libXxf86vm
      libelf
      glib
      gtk2
      networkmanager
      vulkan-loader
      libgbm
      libdrm
      libxcrypt
      coreutils
      pciutils
      zenity
      xorg.libXinerama
      xorg.libXcursor
      xorg.libXrender
      xorg.libXScrnSaver
      xorg.libXi
      xorg.libSM
      xorg.libICE
      gnome2.GConf
      nspr
      nss
      cups
      libcap
      SDL2
      libusb1
      dbus-glib
      ffmpeg
      libudev0-shim
      gtk3
      icu
      libnotify
      gsettings-desktop-schemas
      xorg.libXt
      xorg.libXmu
      libogg
      libvorbis
      SDL
      SDL2_image
      glew110
      libidn
      tbb
      flac
      freeglut
      libjpeg
      libpng
      libpng12
      libsamplerate
      libmikmod
      libtheora
      libtiff
      pixman
      speex
      SDL_image
      SDL_mixer
      SDL_ttf
      SDL2_ttf
      SDL2_mixer
      libappindicator-gtk2
      libdbusmenu-gtk2
      libindicator-gtk2
      libcaca
      libcanberra
      libgcrypt
      libvpx
      librsvg
      xorg.libXft
      libvdpau
      dbus
      freetype
      fontconfig
      fuse
      e2fsprogs
    ];
  };

  environment.systemPackages = with pkgs; [
    git
    vim
    nano
    curl
    wget
    tmux
    zsh
    fastfetch
    btop
    flatpak
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    maple-mono.NF-CN-unhinted
  ];

  fonts.fontconfig = {
    defaultFonts = {
      serif = [ "Noto Serif CJK SC" ];
      sansSerif = [ "Noto Sans CJK SC" ];
      monospace = [ "Maple Mono NF CN" ];
    };
  };

  i18n.defaultLocale = "zh_CN.UTF-8";
  time.timeZone = "Asia/Shanghai";

  hardware.bluetooth.enable = true;
  security.pam.services.swaylock = {};
}
