pkg_origin=cullenmcdermott
pkg_name=zookeeper
pkg_version=3.4.9
pkg_maintainer="Cullen McDermott <cullen@cullenmcdermott.com>"
pkg_license=(Apache2)
pkg_source=https://github.com/apache/$pkg_name/archive/release-$pkg_version.tar.gz
pkg_shasum=dc509fb972036efc09e4e20fc069f356019b27bf670a106c76d67c124c6ebd7c
pkg_deps=(core/gcc-libs core/jdk8/8u102/20161031044127 core/ant core/patch core/autoconf core/cmake core/flex)
pkg_build_deps=(core/wget core/doxygen core/perl core/libtool core/ant core/jdk8/8u102/20161031044127 core/patch core/autoconf core/cmake core/flex core/automake core/autogen paytmlabs/hostname core/make core/which)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
do_build() {
  export JAVA_HOME=$(hab pkg path core/jdk8)
  export JAVA=$(hab pkg path core/jdk8)/bin
  export ANT_HOME=$(hab pkg path core/ant)
  export PATH=$PATH:$ANT_HOME/bin:$JAVA_HOME/bin:$JAVA
  pushd $HAB_CACHE_SRC_PATH/$pkg_name-release-$pkg_version
  ant jar
  hab pkg binlink core/coreutils echo
  hab pkg binlink core/bash bash
}

do_install() {
  return 0
}

#export PATH=$PATH:$(hab pkg path core/jdk8)/bin
#/hab/pkgs/core/bash/4.3.42/20161102154320/bin/bash bin/zkServer.sh start-foreground
