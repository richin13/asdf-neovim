#!/usr/bin/env bash

if [[ "$OSTYPE" == "linux-gnu" ]]; then
  platform=linux64
else
  platform=macos
fi

download_path() {
  local version=$1
  local tmp_download_dir=$2

  echo "$tmp_download_dir/neovim-${version}.zip"
}

download_url() {
  local version=$1

  echo "https://github.com/neovim/neovim/releases/download/${version}/nvim-${platform}.tar.gz"
}

download_version() {
  local version=$1
  local download_path=$2
  local download_url=$(download_url $version)

  echo "curl -Lo $download_path -C - $download_url"
  curl -Lo $download_path -C - $download_url
}
