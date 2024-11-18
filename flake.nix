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

          raylib-vita = pkgs.fetchzip {
            url = "https://github.com/raysan5/raylib/archive/35c777ef2ccdad0b3a94b508ec13df5f6cd9ea49.tar.gz";
            hash = "sha256-lBfiPdnQp23ZOj3RGabHFaF0B5UyYA9Ccw16sCNswq4=";
          };

          vita-packages = {
            zlib = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/zlib.tar.xz";
              hash = "sha256-x+umeK7e5esPVINGHBShWY7wwqkrQMza6FIHfEB9d9c=";
            };
            bzip2 = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/bzip2.tar.xz";
              hash = "sha256-iMr2sVR+gLY0JDxClrnz0f2QN/GB6aNPyiUttDIvuOk=";
            };
            libzip = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/libzip.tar.xz";
              hash = "sha256-Vdl3nFa24m5qIcpWPlRa2UJ3nEbMCPLXKU4WCO7T2g4=";
            };
            libpng = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/libpng.tar.xz";
              hash = "sha256-Dba0ILRf/bW7NTvc0hWt6LbhSjw+fXIPiSmSlhh3syo=";
            };
            libexif = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/libexif.tar.xz";
              hash = "sha256-njbTlQhwOyNOqGm8GM7vPb4gnCfcSc7wByOAQAEIFFo=";
            };
            libjpeg-turbo = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/libjpeg-turbo.tar.xz";
              hash = "sha256-MC6dJpaOwdmgI8DiDhXOWGAdFamIF7o653LNwXVEs+s=";
            };
            jansson = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/jansson.tar.xz";
              hash = "sha256-QuLo+z0yyJhPUfKkiucgOBkJEYO+Mv2ltu2S++goJQE=";
            };
            yaml-cpp = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/yaml-cpp.tar.xz";
              hash = "sha256-lZ8bTL1u+RYU85rzYkf/EIOa19LuUP5pTvgJ0p5SNQU=";
            };
            freetype = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/freetype.tar.xz";
              hash = "sha256-fC+T+IborEdcMwvNI+iwI5zHC5n7jrN1fNxKr7uod64=";
            };
            harfbuzz = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/harfbuzz.tar.xz";
              hash = "sha256-elXYbO9DIHE6BuFxSG4bLD6s6YwXtGFMtd33u5LhYQI=";
            };
            fftw = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/fftw.tar.xz";
              hash = "sha256-WM6+gG6Au+eDHW1q7q8k73zuCjh0zDmC4KtJhmr1kps=";
            };
            libvita2d = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/libvita2d.tar.xz";
              hash = "sha256-Dp/ok4/Q7rU7Xlg52JM9/tBBMRYeHqtP2tCpPuFCShc=";
            };
            libvita2d_ext = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/libvita2d_ext.tar.xz";
              hash = "sha256-TBGjW+RMrUhhC4GRo15JL3EHmgsm+Ax3reWn+lLD9eA=";
            };
            libmad = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/libmad.tar.xz";
              hash = "sha256-7Sdh9fxfp6BEL0c1KCQ2h0lOGrf43znjib/zMOCwsYQ=";
            };
            libogg = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/libogg.tar.xz";
              hash = "sha256-UBiVQ0Ux6NXeFUPo+GpG+3WWk+a6i9ZPFK1g4HcP5Rc=";
            };
            libvorbis = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/libvorbis.tar.xz";
              hash = "sha256-17gAjm3rmv1C+79iiiIcYT7qgwm+gmCmHwVACE3N9kk=";
            };
            flac = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/flac.tar.xz";
              hash = "sha256-zyq9OrDAi8W1FEw5xRkTUF9vixDFGcQGCiGWEQjsB04=";
            };
            libtheora = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/libtheora.tar.xz";
              hash = "sha256-9zBiJNlqjUYKZaWLGtcnYUSuGrZuqVBf3Z1mk19yjCo=";
            };
            libtremor = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/libtremor.tar.xz";
              hash = "sha256-jBropfobd6b4lZo6szwX6nAMj8rm6YbXtI5TtKbeFcg=";
            };
            libmikmod = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/libmikmod.tar.xz";
              hash = "sha256-fn7FXZmH5QPYLHUOlvFgW15Y9fx9C3PpyMiyhWG2HSQ=";
            };
            libftpvita = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/libftpvita.tar.xz";
              hash = "sha256-3a6Aj3GY3deP2gOCH5S4iiZYJiLSSsEYRiu+2SmhEAk=";
            };
            henkaku = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/henkaku.tar.xz";
              hash = "sha256-hNU5M+ryEXz68CnrKRcu+R4HPtmJHI344wwPjW3+nlI=";
            };
            taihen = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/taihen.tar.xz";
              hash = "sha256-rYglZ1LG8HruavdcSSyGhQgKRbCX+paEJs1RewXUyUA=";
            };
            kubridge = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/kubridge.tar.xz";
              hash = "sha256-hZyx5sPE+3AHQ+af+ULUoVpO0VjhP7WciOLYnWLL6RE=";
            };
            libk = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/libk.tar.xz";
              hash = "sha256-Sf0VncRCOHWqJ0f033BrDyi6nSRKdWKwCdRM6roPiak=";
            };
            libdebugnet = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/libdebugnet.tar.xz";
              hash = "sha256-eaMVBWfxerryi8751VDw7voBZXt8HtSovtaMtvU9EB8=";
            };
            onigmo = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/onigmo.tar.xz";
              hash = "sha256-sQkszCSl2yqKRehgGesKgbe7ktPj2rASeFcnI2s6gWw=";
            };
            libwebp = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/libwebp.tar.xz";
              hash = "sha256-i+SB9dWyf7aAPueMoU+L2JXP0IG6mxwJr+kBxIWLPQk=";
            };
            sdl = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/sdl.tar.xz";
              hash = "sha256-PUhi48/17gsfJL/0RZv7IhqPT1YFH33jN3mHn+ElNQw=";
            };
            sdl_image = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/sdl_image.tar.xz";
              hash = "sha256-3k8qeT6EkFIexvdIZkcOSGIP9HfbsgDVx4kRlklrdP0=";
            };
            sdl_mixer = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/sdl_mixer.tar.xz";
              hash = "sha256-B85P9ZhCo3ZLr9CTWS3F8jPDoVlaNx32BN4f2GneOaM=";
            };
            sdl_net = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/sdl_net.tar.xz";
              hash = "sha256-dnvO7O8oAuvnxZRD4ztSXrC3v5+RTWVUwFdxf2JcSg0=";
            };
            sdl_ttf = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/sdl_ttf.tar.xz";
              hash = "sha256-Hj4bWymPwY1EAYmWTZPDKpNLLV4YQAqWVttIrRugaoc=";
            };
            sdl_gfx = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/sdl_gfx.tar.xz";
              hash = "sha256-C5pRvt7DQ/dCEP81oMvPmXZveYpWL/RZB3uK6k0WiWU=";
            };
            sdl2 = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/sdl2.tar.xz";
              hash = "sha256-sPNW23n0zD/SmpNTL0wT0YOd8Z13RTiSnzNrZW5NzgY=";
            };
            sdl2_image = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/sdl2_image.tar.xz";
              hash = "sha256-5DmwCo602eV79JBdN1LfvsC1lcSTYkkOMwZniFV5WEI=";
            };
            sdl2_mixer = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/sdl2_mixer.tar.xz";
              hash = "sha256-C3rK6IeQZgIJ1BRv55/CKI5IOIXcyrKqupzXG8C5s8Y=";
            };
            sdl2_net = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/sdl2_net.tar.xz";
              hash = "sha256-gUyt15AXJ97Gqc2hF4wXmeNOxNbpjzvX5KYIIhMcoM0=";
            };
            sdl2_ttf = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/sdl2_ttf.tar.xz";
              hash = "sha256-J3o4rHIboxXXzLBE2xoSOzJfNYsfxfwbVa9XoMlFlwM=";
            };
            sdl2_gfx = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/sdl2_gfx.tar.xz";
              hash = "sha256-ja0iRwKpG82WYfmjGrWlbK/M4jZkL4brY/x2ai2GwYE=";
            };
            openal-soft = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/openal-soft.tar.xz";
              hash = "sha256-ulke9bYhStI78+bYVmM46KGQg2ma2uA+N7U/e7q8U4o=";
            };
            openssl = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/openssl.tar.xz";
              hash = "sha256-2OuddQ3dMGv5OaAXd98BRKmMBEQPIOvqGTB61MbaSS8=";
            };
            curl = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/curl.tar.xz";
              hash = "sha256-MeQ/oZvZvQkPfWN12wWivfFeix9113mWXd27gUYPypg=";
            };
            curlpp = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/curlpp.tar.xz";
              hash = "sha256-mOdnC1vlQCDcRo5mlGVvJk2KJsl61ZnirQCHr2J5Dzs=";
            };
            expat = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/expat.tar.xz";
              hash = "sha256-Rn0jobvKigrfhi/yeIKOVGGDgvsD8OrRPtoIv5a0u70=";
            };
            opus = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/opus.tar.xz";
              hash = "sha256-ETN6qnXsoUeB7GQf2wEctKu7rSfXp1nhzbTfvpPMzxw=";
            };
            opusfile = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/opusfile.tar.xz";
              hash = "sha256-noAdqCd4z4peapX55ZGPaVjuu4sIr35mN3ozJy3S/Hg=";
            };
            unrar = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/unrar.tar.xz";
              hash = "sha256-JTR5Sh4AcTNYtt5hFzf0i/V+Ug1R7Hxtt1/y8EMZNFM=";
            };
            glm = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/glm.tar.xz";
              hash = "sha256-dFDEDLykmEygzTE95nJ4kMROrrZW6P7yaloDC6Mkmxo=";
            };
            libxml2 = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/libxml2.tar.xz";
              hash = "sha256-xNZwpEapP8NhMXGRWqCz1O3e0uaR7Pd0fuLoqcA3ts8=";
            };
            speexdsp = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/speexdsp.tar.xz";
              hash = "sha256-rAGOW/Qhbpv88LvRJwTh35Ax1OANTRiTN9Ise/FfOoE=";
            };
            pixman = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/pixman.tar.xz";
              hash = "sha256-8o+WVgzLNFUm3TyxTBoDPi52e3Ybb7lATbcjgH0zCyE=";
            };
            TinyGL = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/TinyGL.tar.xz";
              hash = "sha256-Mf+Ec6zJ1FNukBFqhUcS1t+0VFCXwXdby8fZJVEmFCc=";
            };
            kuio = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/kuio.tar.xz";
              hash = "sha256-4+NhWoAXuI+QAJa4rsp68GXUXKRide14VfcvInzgJAQ=";
            };
            taipool = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/taipool.tar.xz";
              hash = "sha256-oGdLeSOFROTiwBFZhCt4jLgBmkdhamZ1XNaqgbNFSzQ=";
            };
            mpg123 = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/mpg123.tar.xz";
              hash = "sha256-jB2+4/Zd6P6Goh3/sTRSTrHWIdjfRBo8MUoreC+CRBI=";
            };
            libmpeg2 = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/libmpeg2.tar.xz";
              hash = "sha256-uLjCDhdaooglF5RXb6FWmjkECUEbTNVh3HgPk1+9OEg=";
            };
            soloud = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/soloud.tar.xz";
              hash = "sha256-U5bZnXgI2TlWqExMcf6odhpY5Y/rDfQira4Z+GsxwI8=";
            };
            quirc = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/quirc.tar.xz";
              hash = "sha256-j/WV0cDfe+NJr96CAkUj7KR1YcRvOKFkWn9oKpY7DKU=";
            };
            Box2D = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/Box2D.tar.xz";
              hash = "sha256-XOcy3JQq+NtlQq7LA7mbhuHNNs2CHaY1RW4qw4xTo5k=";
            };
            libsndfile = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/libsndfile.tar.xz";
              hash = "sha256-PpHHcyngqjRs6oA5UvDk72n+1FIA/jG8jGU6TbGLo7U=";
            };
            xz = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/xz.tar.xz";
              hash = "sha256-VLE0mkl0next01YAsOq65pDTx9WKFe/o9gOPhqN0JIA=";
            };
            libarchive = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/libarchive.tar.xz";
              hash = "sha256-W9bz8+UCF5PVLJ8uWUAxQalX/J33KaMcHormprSLKCA=";
            };
            bullet = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/bullet.tar.xz";
              hash = "sha256-A82MXdsxlkhB4X+4rViBs6cg3JxAt+o6WBrjgx52X/M=";
            };
            libimagequant = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/libimagequant.tar.xz";
              hash = "sha256-e+nj4XPIv0gUZteLVeG8twCcGobc5XKhsMSDOPIrlXU=";
            };
            libmodplug = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/libmodplug.tar.xz";
              hash = "sha256-cRYTt8FBtE8tzfIgWcm505WcAwJt/zlOh+kdMTqtcik=";
            };
            libconfig = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/libconfig.tar.xz";
              hash = "sha256-2DFPcgDp5HUMqi6L0y+gyIw3Tdc935fNOshE/a+6Na0=";
            };
            libsodium = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/libsodium.tar.xz";
              hash = "sha256-qregY/DMuqCZ3hTMWtRl61MnWqUhJz0rE4eYwhPBL1k=";
            };
            vitaShaRK = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/vitaShaRK.tar.xz";
              hash = "sha256-uWfloA0J3g8pW4GAKxn+BG+zEzHqEzC+/wPzAO6xaCo=";
            };
            libmathneon = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/libmathneon.tar.xz";
              hash = "sha256-/x9/T/8ZNf7rgVzal5mH9vkXZCVU94nCp4vOsr5ZFTA=";
            };
            vitaGL = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/vitaGL.tar.xz";
              hash = "sha256-ZJBBv6TRJn9gN7wIXEUxjKfKVXWh4VBD84DDM2d7Kqk=";
            };
            imgui = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/imgui.tar.xz";
              hash = "sha256-hAA1Sk5D8AKAL+a1A6tUuBbRy1JfsTlNc1UBOC0H99U=";
            };
            imgui-vita2d = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/imgui-vita2d.tar.xz";
              hash = "sha256-FSETzyN7LF2v9DT6x7pxxB7Q2HnbGTUsHaAuQtOFaCQ=";
            };
            libbaremetal = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/libbaremetal.tar.xz";
              hash = "sha256-9lBe328M8XM2Vva3Add+a7T9pKx4Z6r1n6BCgRR4Yo4=";
            };
            minizip = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/minizip.tar.xz";
              hash = "sha256-KMbGZLzyYs4U05NUaoclLm2MAGwVVBKTwn3uBHgAG0U=";
            };
            jsoncpp = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/jsoncpp.tar.xz";
              hash = "sha256-XLEB283XxLeuWpGJ3p0xEa0XQAYkFd+g8ikgtRlh35E=";
            };
            lame = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/lame.tar.xz";
              hash = "sha256-axyWVxC5DJSlFjJKznfZm0YE7uZg5KjsvTvCI/BBahE=";
            };
            ffmpeg = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/ffmpeg.tar.xz";
              hash = "sha256-izCBNB9+EC07fbWEOHufEkxywDdyo1koMEo4M/BgKsg=";
            };
            physfs = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/physfs.tar.xz";
              hash = "sha256-uT7p3bEIJRK8jkDp0CNEfZYiHPRZ3m5AdPDABlJ3so4=";
            };
            vita-rss-libdl = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/vita-rss-libdl.tar.xz";
              hash = "sha256-k/NsNyT6Sz/CzuzAVBrDLFimhaPwi256zjdx7GUvoC0=";
            };
            luajit = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/luajit.tar.xz";
              hash = "sha256-f0jffP24oZUiEwnKMLFU+lBTa5VKZaBp+T+epUqd8/0=";
            };
            tinyxml2 = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/tinyxml2.tar.xz";
              hash = "sha256-DpRdRfhfImxljygPPsqvvsDHwY5cnj4TvZ3oxp56tHo=";
            };
            cpython = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/cpython.tar.xz";
              hash = "sha256-bnTElkBcABetS7al1CZ1fQa63R02Vbozofnl3Vw26L8=";
            };
            cpython3 = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/cpython3.tar.xz";
              hash = "sha256-5o0JgnftpZ1cKRKjDarlCyMEnhQAp6LyBOqoVzTKapY=";
            };
            asio = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/asio.tar.xz";
              hash = "sha256-mGG+xnP0cBzIDC7A3JomRfqZ8dWRHBPPx0mKYsTGcPA=";
            };
            assimp = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/assimp.tar.xz";
              hash = "sha256-6mPLyGjj9G9EDJPKs+ueaFo53FiOy1D3RvWs13vuhUM=";
            };
            opensles = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/opensles.tar.xz";
              hash = "sha256-fljmZUuCvmrul+CycTJOj2Qs4Lg4ad6xTLQUjFzYQ2o=";
            };
            cpr = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/cpr.tar.xz";
              hash = "sha256-72kWG3+a+Mwhx79BdQWI5zP2bxYkrai1bac2Xilmuzk=";
            };
            libintl = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/libintl.tar.xz";
              hash = "sha256-NVOgWNY0agvFNyj5TSVLHop6XqycghsINBZHegTewHg=";
            };
            libopenmpt = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/libopenmpt.tar.xz";
              hash = "sha256-DIMgb+rBqP9+q6IdqZzzO/f+fsisyPjW2LMEc6xZmnY=";
            };
            libvpx = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/libvpx.tar.xz";
              hash = "sha256-0H1sS3W9tHYavQ7bkJGaOWrfeZbaSOtIukMNjLZ2Uns=";
            };
            zstd = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/zstd.tar.xz";
              hash = "sha256-DsqWw74tXE3lNdOVsu72HE7mRc9Ax6uxjqg/CIZT/Oc=";
            };
            libpcre2 = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/libpcre2.tar.xz";
              hash = "sha256-ynGtOLzZFo1KEDW0K+nwOnp6uEHcHUxcUGrMFV3qqSQ=";
            };
            fribidi = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/fribidi.tar.xz";
              hash = "sha256-bgjASk/2sItm5kvdJHCvnZNy/uadGQ7ZffdIbUDguOs=";
            };
            libass = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/libass.tar.xz";
              hash = "sha256-4mFYE3oX7UKSxdEzAO/vctoQZ6UlhnHwTvp0auaNA3U=";
            };
            websocketpp = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/websocketpp.tar.xz";
              hash = "sha256-x/lQyXLMssNtXC4RDUmsbErmirJ4g1g4RqzJsCA44rw=";
            };
            wslay = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/wslay.tar.xz";
              hash = "sha256-rDpBpM2fMlSPlqirrTXW9qNEuX+g8GsvZcnLT4V9J5o=";
            };
            SceShaccCgExt = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/SceShaccCgExt.tar.xz";
              hash = "sha256-3MWAtwifNIXwcY9Gq+OzywT7cwroiZ0FqPfMEwu/DXo=";
            };
            boost = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/boost.tar.xz";
              hash = "sha256-9S52ezySX1+GV2XxtxpdLKqDNKl4bOWIXON3OJ8Kg+0=";
            };
            pib = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/pib.tar.xz";
              hash = "sha256-CJXpGekgV35Cd4qJMQO598OrMiO9QdwzLpmnqYdlbyc=";
            };
            libxmp = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/libxmp.tar.xz";
              hash = "sha256-pLbvcCn4V+uK3jgEVnvobp2whTD3K27V0n7tMjy38kg=";
            };
            libxmp-lite = pkgs.fetchurl {
              url = "https://github.com/vitasdk/packages/releases/download/master/libxmp-lite.tar.xz";
              hash = "sha256-fh4ybt2DLwxVIQqtvdr7v0nvwxFob7f+FJPg8sQWkBo=";
            };
          };
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
                  --prefix PATH : ${lib.makeBinPath [pkgs.curl]}

                export VITASDK_ROOT="$VITASDK/arm-vita-eabi"
              ''
              + builtins.concatStringsSep "\n" (map (
                  package: ''
                    tar -C $VITASDK_ROOT -Jxvf ${package}
                  ''
                )
                vita-packages-list);
          };

          raylib-lib = pkgs.stdenvNoCC.mkDerivation {
            name = "vitasdk-raylib";
            version = "4.2";

            src = raylib-vita;
            patches = [./vitasdk_raylib_4.2.0.patch];

            nativeBuildInputs = with pkgs; [
              gnupatch
              self.packages.${system}.default
              gnumake
            ];

            installPhase = ''
              cd $src/src
              make -j$(nproc)

              make DESTDIR=$TMP/out install
              tar cf $out/vita-raylib.tar.xz $TMP/out/*
            '';
          };
        };
      }
    );

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
}
