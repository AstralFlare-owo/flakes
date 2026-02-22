{
  description = "AstRiverse RE Compute Node - NixOS Flakes";

  nixConfig = {
    substituters = [
      # TUNA Mirror
      # "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      # NJU Mirror
      # "https://mirrors.nju.edu.cn/nix-channels/store"
      # NixOS Official
      "https://cache.nixos.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
    experimental-features = [ "nix-command" "flakes" ];
  };

  inputs = {
    # NixOS Nixpkgs

    # [TUNA Mirror]
    # nixpkgs.url = "git+https://mirrors.tuna.tsinghua.edu.cn/git/nixpkgs.git?ref=nixos-unstable&shallow=1";
    # [NJU Mirror]
    nixpkgs.url = "git+https://mirror.nju.edu.cn/git/nixpkgs.git?ref=nixos-unstable&shallow=1";
    # [Github]
    # nixpkgs.url = "git+https://github.com/NixOS/nixpkgs.git?ref=nixos-unstable&shallow=1";

    # NixOS Hardware Configurations

    # [ghfast.top Mirror]
    nixos-hardware.url = "git+https://ghfast.top/https://github.com/NixOS/nixos-hardware.git?shallow=1";
    # [Github]
    # nixos-hardware.url = "git+https://github.com/NixOS/nixos-hardware.git?shallow=1";

    # Nix User Repository
    nur = {
      # [ghfast.top Mirror]
      url = "git+https://ghfast.top/https://github.com/nix-community/NUR.git?shallow=1";
      # [Github]
      # url = "git+https://github.com/nix-community/NUR.git?shallow=1";

      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home Manager
    home-manager = {
      # [ghfast.top Mirror]
      url = "git+https://ghfast.top/https://github.com/nix-community/home-manager.git?shallow=1";
      # [Github]
      # url = "git+https://github.com/nix-community/home-manager.git?shallow=1";

      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      # [ghfast.top Mirror]
      url = "git+https://ghfast.top/https://github.com/noctalia-dev/noctalia-shell.git?shallow=1";
      # [Github]
      # url = "git+https://github.com/noctalia-dev/noctalia-shell.git?shallow=1";

      inputs.nixpkgs.follows = "nixpkgs";
    };

    openclaw = {
      # [ghfast.top Mirror]
      url = "git+https://ghfast.top/https://github.com/openclaw/nix-openclaw.git?shallow=1";
      # [Github]
      # url = "git+https://github.com/openclaw/nix-openclaw.git?shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fix-python = {
      # [ghfast.top Mirror]
      url = "git+https://ghfast.top/https://github.com/GuillaumeDesforges/fix-python.git?shallow=1";
      # [Github]
      # url = "git+https://github.com/GuillaumeDesforges/fix-python.git?shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, nixos-hardware, nur, home-manager, ...}@inputs:
  let
    specialArgs = { inherit inputs; };
  in {
    nixosModules = {
      nur = { ... }: {
        nixpkgs.overlays = [
          inputs.nur.overlays.default
          inputs.openclaw.overlays.default
        ];
      };
      nixpkgs = { ... }: {
        nixpkgs.config.allowUnfree = true;
      };
    };

    nixosConfigurations = {
      g5000 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = specialArgs;
        modules = [
          self.nixosModules.nur
          self.nixosModules.nixpkgs
          ./hosts/g5000/configuration.nix
          nixos-hardware.nixosModules.lenovo-legion-16irx8h
          home-manager.nixosModules.home-manager
        ];
      };

      hyperv = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = specialArgs;
        modules = [
          self.nixosModules.nur
          self.nixosModules.nixpkgs
          ./hosts/hyperv/configuration.nix
          home-manager.nixosModules.home-manager
        ];
      };
    };
  };
}
