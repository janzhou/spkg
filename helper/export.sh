#! /bin/sh

if [ "$build_dir" == "" ]; then
  export build_dir=$HOME/build
fi

if [ "$source_dir" == "" ]; then
  export source_dir=$HOME/source
fi

if [ "$root" == "" ]; then
  export root=$HOME/root
fi

export PATH=$root/bin:$PATH
export PKG_CONFIG_PATH=$root/lib/pkgconfig:$PKG_CONFIG_PATH
export LDFLAGS="-L$root/lib $LDFLAGS"
export CPPFLAGS="-I$root/include $CPPFLAGS"
export PERL5OPT="-I$root/lib/perl -I$root/lib64/perl5"
