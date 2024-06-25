#! /usr/bin/env zsh

# This script installs the pictools scripts.

function install_pictools {
  # Copy the scripts to /usr/local/bin
  cp src/* /usr/local/bin/
  chmod -R +x /usr/local/bin/*
  echo "Scripts copied to /usr/local/bin"

  # Copy the configuration file to /usr/local/etc
  cp cfg/pictools.cfg /usr/local/etc/
  chmod +x /usr/local/etc/pictools.cfg
  echo "Configuration file copied to /usr/local/etc"

  echo "Done."
}

# Check if the script is being executed as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
else
  install_pictools
fi

unset -f install_pictools
