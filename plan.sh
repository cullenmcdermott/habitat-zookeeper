pkg_origin=cullenmcdermott
pkg_name=zookeeper
pkg_version=3.4.9
pkg_maintainer="Cullen McDermott <cullen@cullenmcdermott.com>"
pkg_license=(Apache2)
pkg_source=https://www.apache.org/dist/zookeeper/zookeeper-$pkg_version/zookeeper-$pkg_version.tar.gz
pkg_shasum=e7f340412a61c7934b5143faef8d13529b29242ebfba2eba48169f4a8392f535
pkg_deps=(core/coreutils core/gcc-libs core/jdk8/8u102/20161031044127 core/bash)
pkg_build_deps=(core/ant core/jdk8/8u102/20161031044127 core/inetutils)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_svc_run="\$(hab pkg path core/bash)/bin/bash zkServer.sh start-foreground"
pkg_expose=(2181)
do_build() {
  export JAVA_HOME=$(hab pkg path core/jdk8)
  export JAVA=$(hab pkg path core/jdk8)/bin
  export ANT_HOME=$(hab pkg path core/ant)
  export PATH=$PATH:$ANT_HOME/bin:$JAVA_HOME/bin:$JAVA
  pushd $HAB_CACHE_SRC_PATH/$pkg_name-$pkg_version
  ant jar
  fix_interpreter "bin/*.sh" core/coreutils bin/env
}

do_install() {
  mv $HAB_CACHE_SRC_PATH/$pkg_dirname/* $pkg_prefix
  mv $pkg_prefix/conf/zoo_sample.cfg $pkg_prefix/conf/zoo.cfg
}
