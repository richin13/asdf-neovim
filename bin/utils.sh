#!/usr/bin/env bash

case "$(uname -s)" in
  "Linux")
    platform=linux64
    ;;
  "Darwin")
    platform=macos
    ;;
esac

download_path() {
  local version=$1
  local tmp_download_dir=$2

  echo "$tmp_download_dir/neovim-${version}.tar.gz"
}

download_url() {
  local version_arg="$1"
  if [[ "$version_arg" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    local version="v$1"
  else
    local version="$1"
  fi
  echo "https://github.com/neovim/neovim/releases/download/${version}/nvim-${platform}.tar.gz"
}

download_version() {
  local version=$1
  local download_path=$2
  local download_url=$(download_url $version)

  echo "curl -Lo $download_path -C - $download_url"
  curl -Lo $download_path -C - $download_url
}
