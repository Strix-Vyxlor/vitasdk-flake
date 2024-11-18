#!/bin/bash

all_packages=(
  "zlib"
  "bzip2"
  "libzip"
  "libpng"
  "libexif"
  "libjpeg-turbo"
  "jansson"
  "yaml-cpp"
  "freetype"
  "harfbuzz"
  "fftw"
  "libvita2d"
  "libvita2d_ext"
  "libmad"
  "libogg"
  "libvorbis"
  "flac"
  "libtheora"
  "libtremor"
  "libmikmod"
  "libftpvita"
  "henkaku"
  "taihen"
  "kubridge"
  "libk"
  "libdebugnet"
  "onigmo"
  "libwebp"
  "sdl"
  "sdl_image"
  "sdl_mixer"
  "sdl_net"
  "sdl_ttf"
  "sdl_gfx"
  "sdl2"
  "sdl2_image"
  "sdl2_mixer"
  "sdl2_net"
  "sdl2_ttf"
  "sdl2_gfx"
  "openal-soft"
  "openssl"
  "curl"
  "curlpp"
  "expat"
  "opus"
  "opusfile"
  "unrar"
  "glm"
  "libxml2"
  "speexdsp"
  "pixman"
  "TinyGL"
  "kuio"
  "taipool"
  "mpg123"
  "libmpeg2"
  "soloud"
  "quirc"
  "Box2D"
  "libsndfile"
  "xz"
  "libarchive"
  "bullet"
  "libimagequant"
  "libmodplug"
  "libconfig"
  "libsodium"
  "vitaShaRK"
  "libmathneon"
  "vitaGL"
  "imgui"
  "imgui-vita2d"
  "libbaremetal"
  "minizip"
  "jsoncpp"
  "lame"
  "ffmpeg"
  "physfs"
  "vita-rss-libdl"
  "luajit"
  "tinyxml2"
  "cpython"
  "cpython3"
  "asio"
  "assimp"
  "opensles"
  "cpr"
  "libintl"
  "libopenmpt"
  "libvpx"
  "zstd"
  "libpcre2"
  "fribidi"
  "libass"
  "websocketpp"
  "wslay"
  "SceShaccCgExt"
  "boost"
  "pib"
  "libxmp"
  "libxmp-lite"
)

get_hash() {
  echo $(nix-prefetch-url https://github.com/vitasdk/packages/releases/download/master/$1.tar.xz --print-path | head -1)
}

hash_sri() {
  nix hash convert --hash-algo sha256 $1
}

format_hash() {
  name=$1
  hash=$(hash_sri $(get_hash $name))
  echo "  $name = pkgs.fetchurl {
     url = \"https://github.com/vitasdk/packages/releases/download/master/$name.tar.xz\";
     hash = \"$hash\";
  };"
}

format() {
  echo "{"
  for pack in $1; do
   format_hash $pack 
  done
  echo "}"
}

echo "{"

if [[ $1 == "" ]]; then
  for package in ${all_packages[@]}; do
    format_hash $package
  done
else
  for package in "$@"; do
    format_hash $package
  done
fi

echo "}"
