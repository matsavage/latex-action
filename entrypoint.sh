#!/bin/sh

set -e

root_file="$1"
working_directory="$2"
compiler="$3"
args="$4"
extra_system_packages="$5"
runs="$6"

if [ -n "$extra_system_packages" ]; then
  apt-get update
  for pkg in $extra_system_packages; do
    echo "Install $pkg by apt"
    apt-get -y install "$pkg"
  done
fi

if [ -n "$working_directory" ]; then
  cd "$working_directory"
fi

export TEXMFHOME=$(kpsewhich -var-value TEXMFLOCAL)

for i in `seq 1 $runs`
do
  echo $i
  "$compiler" $args "$root_file"
done

