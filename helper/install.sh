#! /bin/sh

. $spkg_dir/pkg/$1

info() { echo -e "\033[1;32m>>> \033[0m$@"; }
error() { echo -e "\033[1;31m>>> \033[0m$@" >&2; }
die() { error "$@"; exit 1; }
run() { "$@" || die "Command '$@' failed."; }

fetch () {
  if [ ! -e $source_dir/$name-$version.$extension ] ; then
    run wget --no-check-certificate -O $source_dir/$name-$version.$extension $source
  fi
}

config () {
  mkdir -p "${build_dir}/${name}-${version}"
  run tar xf $source_dir/$name-$version.$extension --strip-components 1 -C "${build_dir}/${name}-${version}"
  cd "${build_dir}/${name}-${version}"
  type ${name}_config &>/dev/null && run ${name}_config || run ./configure --prefix=$root
}

build () {
  cd "${build_dir}/${name}-${version}"
  type ${name}_build &>/dev/null && run ${name}_build || run make
}

install () {
  cd "${build_dir}/${name}-${version}"
  type ${name}_install &>/dev/null && run ${name}_install || run make install
}

fetch
config
build
install
