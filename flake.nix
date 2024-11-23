{
  description = "vitasdk toolchain";

  outputs = inputs @ {self, ...}:
    inputs.flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import inputs.nixpkgs {
          inherit system;
        };

        lib = pkgs.lib;
      in {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            cmake
            gnupatch
            self.packages.${system}.default
          ];

          VITASDK = "${self.packages.${system}.default}";
        };

        packages = let
          vitasdk-src = pkgs.fetchurl {
            url = "https://github.com/vitasdk/autobuilds/releases/download/master-linux-v2.527/vitasdk-x86_64-linux-gnu-2024-08-09_11-28-39.tar.bz2";
            hash = "sha256-q40UNshM/rWwQKCn5teGf0z4FQCJOpMUu9KUsqfwIqE=";
          };

          raylib-vita = ./raylib4Vita.tar.gz;

          vita-packages = import ./packages.nix {inherit pkgs;};
          vita-packages-list = lib.attrsets.mapAttrsToList (name: value: value) vita-packages;
        in {
          bare = pkgs.stdenvNoCC.mkDerivation {
            name = "vitasdk-bare";
            version = "master-v2.527";

            src = vitasdk-src;
            dontUnpack = true;

            nativeBuildInputs = with pkgs; [
              gnupatch
              makeWrapper
              python312
            ];

            installPhase = ''
              export VITASDK=$out/
              mkdir -p $VITASDK
              tar xjf ${vitasdk-src} -C $VITASDK --strip-components=1
            '';
          };

          default = pkgs.stdenvNoCC.mkDerivation {
            name = "vitasdk";
            version = "master-v2.527";

            src = vitasdk-src;
            dontUnpack = true;

            nativeBuildInputs = with pkgs; [
              gnupatch
              makeWrapper
              python312
            ];

            installPhase =
              ''
                export VITASDK=$out/
                mkdir -p $VITASDK
                tar xjf ${vitasdk-src} -C $VITASDK --strip-components=1

                wrapProgram $out/bin/vita-makepkg \
                  --prefix PATH : ${lib.makeBinPath [pkgs.curl pkgs.libarchive pkgs.fakeroot]}

                export VITASDK_ROOT="$VITASDK/arm-vita-eabi"
              ''
              + builtins.concatStringsSep "\n" (map (
                  package: ''
                    tar -C $VITASDK_ROOT -Jxf ${package}
                  ''
                )
                vita-packages-list);
          };

          raylib = pkgs.stdenvNoCC.mkDerivation {
            name = "vitasdk";
            version = "master-v2.527";

            src = vitasdk-src;
            dontUnpack = true;

            nativeBuildInputs = with pkgs; [
              gnupatch
              makeWrapper
              python312
            ];

            installPhase =
              ''
                export VITASDK=$out/
                mkdir -p $VITASDK
                tar xjf ${vitasdk-src} -C $VITASDK --strip-components=1

                wrapProgram $out/bin/vita-makepkg \
                  --prefix PATH : ${lib.makeBinPath [pkgs.curl]}

                export VITASDK_ROOT="$VITASDK/arm-vita-eabi"
                 tar -C $VITASDK_ROOT -xf ${raylib-vita}
              ''
              + builtins.concatStringsSep "\n" (map (
                  package: ''
                    tar -C $VITASDK_ROOT -Jxf ${package}
                  ''
                )
                vita-packages-list);
          };
        };
      }
    );

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
}
