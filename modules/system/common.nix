{ pkgs, ... }: {
  imports = [
    ./virtualisation/docker.nix
    ./network/bonjour.nix
  ];

  boot.loader.systemd-boot.enable = true;

  networking.networkmanager.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
    "olm-3.2.16"
    "pnpm-10.29.2"
  ];

  services.openssh.enable = true;
  services.flatpak.enable = true;
  programs.appimage = {
    enable = true;
    binfmt = true;
  };
  services.xserver.excludePackages = [ pkgs.xterm ];
  programs.zsh.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.atd.enable = true;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      zlib
      zstd
      stdenv.cc.cc
      stdenv.cc.cc.lib
      gcc-unwrapped.lib
      curl
      openssl
      expat
      attr
      libssh
      bzip2
      libxml2
      acl
      libsodium
      util-linux
      xz
      systemd
      libxcomposite
      libxtst
      libxrandr
      libxext
      libx11
      libxfixes
      libGL
      libva
      pipewire
      libxcb
      libxdamage
      libxshmfence
      libxxf86vm
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
      libxinerama
      libxcursor
      libxrender
      libxscrnsaver
      libxi
      libsm
      libice
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
      libxt
      libxmu
      libogg
      libvorbis
      SDL
      SDL2_image
      glew_1_10
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
      libxft
      libvdpau
      dbus
      freetype
      fontconfig
      fuse
      e2fsprogs
      mesa
      libxkbcommon
      at-spi2-core
      at-spi2-atk
      alsa-lib
      libpulseaudio
      libsecret
      systemd
      pango
      cairo
      gdk-pixbuf
      libglvnd
    ];
  };

  programs.git.enable = true;
  programs.vim.enable = true;
  programs.nano.enable = true;
  programs.tmux.enable = true;

  environment.systemPackages = with pkgs; [
    nano-syntax-highlighting
    curl
    wget
    fastfetch
    btop
    gh
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    maple-mono.NF-CN-unhinted
    corefonts
    vista-fonts
    vista-fonts-chs
  ];

  fonts.fontconfig = {
    defaultFonts = {
      serif = [
        "Noto Serif"
        "Noto Serif CJK SC"
        "Noto Color Emoji"
      ];
      sansSerif = [
        "Noto Sans"
        "Noto Sans CJK SC"
        "Noto Color Emoji"
      ];
      monospace = [ "Maple Mono NF CN" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };

  i18n.defaultLocale = "zh_CN.UTF-8";
  time.timeZone = "Asia/Shanghai";

  hardware.bluetooth.enable = true;
  security.pam.services.swaylock = { };
}
