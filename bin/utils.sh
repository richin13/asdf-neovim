#!/usr/bin/env bash

download_path() {
  local version=$1
  local tmp_download_dir=$2

  echo "$tmp_download_dir/neovim-${version}.tar.gz"
}

download_version() {
  local install_type=$1
  local version=$2
  local download_path=$3
  local download_url

  download_url=$(download_url "$install_type" "$version")

  [ -f $download_path ] && rm "$download_path"

  echo "==> curl -Lo $download_path -C - $download_url"
  curl -Lo "$download_path" -C - "$download_url" || exit 1
}

download_url() {
  local install_type=$1
  local version_arg=$2
  local version
  if [[ "${version_arg}" =~ ^[0-9]+\.[0-9]+\.[0-9]+ ]]; then
    version="v$2"
  else
    version="$2"
  fi

  case "$(uname -s)" in
    "Linux")
      # Check version is less than v0.10.3 - if it is, use the old platform name
      # using IFS to split the version number into an array
      IFS='.' read -r -a version_array <<<"${version#v}"

      # version_array[0] is the major version, version_array[1] is the minor version and version_array[2] is the patch version
      if (((version_array[0] == 0 && version_array[1] <= 9)) \
          || ((version_array[0] == 0 && version_array[1] <= 10 && version_array[2] <= 3))) \
          && [[ ! $version =~ ^stable|nightly$ ]]; then
        platform=linux64
      else
        platform="linux-$(uname -m)"
      fi
      ;;
    "Darwin")
      # Check version is less than v0.10.0 - if it is, use the old platform name
      # using IFS to split the version number into an array
      IFS='.' read -r -a version_array <<<"${version#v}"

      # version_array[0] is the major version and version_array[1] is the minor version
      if ((version_array[0] == 0 && version_array[1] < 10)) && [[ ! $version =~ ^stable|nightly$ ]]; then
        platform=macos
      else
        case "$(uname -p)" in
          "arm")
            platform=macos-arm64
            ;;
          *)
            platform=macos-x86_64
            ;;
        esac
      fi
      ;;
  esac

  if [ "$install_type" = "version" ]; then
    echo "https://github.com/neovim/neovim/releases/download/${version}/nvim-${platform}.tar.gz"
  else
    # otherwise it can be a branch name or commit sha
    echo "https://github.com/neovim/neovim/archive/${version}.tar.gz"
  fi

  return
}

download_neovim() {
  local install_type=$1
  local version=$2
  local download_path=$3
  local tmp_download_dir
  local archive_path

  if [ "$TMPDIR" = "" ]; then
    tmp_download_dir=$(mktemp -d -t neovim_build_XXXXXX)
  else
    tmp_download_dir=$TMPDIR
  fi

  archive_path=$(download_path "$version" "$tmp_download_dir")
  download_version "$install_type" "$version" "$archive_path"

  # running this in subshell
  # we don't want to disturb current working dir
  (
    if ! type "tar" &>/dev/null; then
      echo "ERROR: tar not found"
      exit 1
    fi

    tar zxf "$archive_path" -C "$download_path" --strip-components=1 || exit 1
  )
}
