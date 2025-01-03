TERMUX_PKG_HOMEPAGE=https://github.com/ptitSeb/box64
TERMUX_PKG_DESCRIPTION="Linux Userspace x86_64 Emulator with a twist"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=0.3.2
TERMUX_PKG_SRCURL=git+https://github.com/simbake/box64
TERMUX_PKG_GIT_BRANCH=v0.3.2
#TERMUX_PKG_SHA256=e334e793638f375a28829c01b089c6ba27d8c3f6094fcbc9360b56ad9c09d0b5
TERMUX_PKG_DEPENDS="gcc-libs-glibc"
TERMUX_PKG_BLACKLISTED_ARCHES="arm, i686, x86_64"
#TERMUX_PKG_BUILD_DEPENDS="cmake-glibc make-glibc python-glibc"
TERMUX_CMAKE_BUILD="Unix Makefiles"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="-DCMAKE_BUILD_TYPE=RelWithDebInfo"
TERMUX_PKG_RM_AFTER_INSTALL="etc/binfmt.d"
#_PREFIX=/data/data/com.termux/files/usr/glibc
termux_step_pre_configure() {
		TERMUX_PKG_EXTRA_CONFIGURE_ARGS+="-DARM_DYNAREC=ON -DBOX32=ON -DBOX32_BINFMT=1"
}

termux_step_make_install() {
		make install
}
