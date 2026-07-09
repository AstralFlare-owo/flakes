{ inputs, lib, ... }: {
  nixpkgs.overlays = [
    (final: prev: {
      libfprint = prev.libfprint.overrideAttrs (oldAttrs: {
        version = "cs9711";
        src = final.fetchFromGitHub {
          owner = "archeYR";
          repo = "libfprint-CS9711";
          rev = "02b285c9703c38d308fbe47a3c566ef1e7f883ca";
          hash = "sha256-QGrBNqbRNqLZIURI66xkenlQamNW+DQU4WS+CLN4zM8=";
        };
        nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ [
          final.cmake
          final.doctest
        ];
        buildInputs = (oldAttrs.buildInputs or [ ]) ++ [ final.opencv ];
      });
    })
  ];

  security.pam.services.login.fprintAuth = lib.mkForce true;
  services.fprintd.enable = true;
}
