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
    nixpkgs.url = "git+https://mirrors.tuna.tsinghua.edu.cn/git/nixpkgs.git?ref=nixos-unstable";
    # [NJU Mirror]
    # nixpkgs.url = "git+https://mirrors.nju.edu.cn/nixpkgs.git?ref=nixos-unstable";
    # [Github]
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # NixOS Hardware Configurations

    # [ghfast.top Mirror]
    nixos-hardware.url = "git+https://ghfast.top/https://github.com/NixOS/nixos-hardware.git";
    # [Github]
    # nixos-hardware.url = "github:NixOS/nixos-hardware";

    # Nix User Repository
    nur = {
      # [ghfast.top Mirror]
      url = "git+https://ghfast.top/https://github.com/nix-community/NUR.git";
      # [Github]
      # url = "github:nix-community/NUR";

      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home Manager
    home-manager = {
      # [ghfast.top Mirror]
      url = "git+https://ghfast.top/https://github.com/nix-community/home-manager.git";
      # [Github]
      # url = "github:nix-community/home-manager";

      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      # [ghfast.top Mirror]
      url = "git+https://ghfast.top/https://github.com/noctalia-dev/noctalia-shell.git";
      # [Github]
      # url = "github:noctalia-dev/noctalia-shell";

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
