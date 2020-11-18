#!/usr/bin/env bash

if [[ "$OSTYPE" == "linux-gnu" ]]; then
  platform=linux64
else
  platform=macos
fi

download_path() {
  local version=$1
  local tmp_download_dir=$2

  echo "$tmp_download_dir/neovim-${version}.tar.gz"
}

download_version() {
  local version=$1
  local download_path=$2
  local download_url=$(download_url $version)

  rm $download_path

  echo "curl -Lo $download_path -C - $download_url"
  curl -Lo $download_path -C - $download_url || exit 1
}

download_url() {
  if [ "$install_type" = "version" ]; then
    local version_arg="$1"
    if [[ "$version_arg" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
      local version="v$1"
    else
      local version="$1"
    fi
    echo "https://github.com/neovim/neovim/releases/download/${version}/nvim-${platform}.tar.gz"
  else
    local version
    version=$1

    if [[ "${version}" =~ ^[0-9]+\.* ]] ; then
      # if version is a release number, prepend v
      echo "https://github.com/neovim/neovim/archive/v${version}.tar.gz"
    else
      # otherwise it can be a branch name or commit sha
      echo "https://github.com/neovim/neovim/archive/${version}.tar.gz"
    fi
  fi

  return
}
