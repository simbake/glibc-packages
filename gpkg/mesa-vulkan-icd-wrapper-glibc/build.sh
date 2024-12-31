TERMUX_PKG_HOMEPAGE="https://www.mesa3d.org"
TERMUX_PKG_DESCRIPTION="An open-source implementation of the OpenGL specification"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_LICENSE_FILE="docs/license.rst"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION="24.2.6"
TERMUX_PKG_SRCURL=git+https://github.com/simbake/mesa2
TERMUX_PKG_GIT_BRANCH=main
#TERMUX_PKG_SHA256=2b68c4a6f204c1999815a457299f81c41ba7bf48c4674b0b2d1d8864f41f3709
TERMUX_PKG_DEPENDS="vulkan-headers-glibc, libwayland-protocols-glibc, libglvnd-glibc, gcc-libs-glibc, libdrm-glibc, libllvm-glibc, libexpat-glibc, zlib-glibc, zstd-glibc, libx11-glibc, libxcb-glibc, libxext-glibc, libxfixes-glibc, libxshmfence-glibc, libxxf86vm-glibc, libwayland-glibc, libvdpau-glibc, libomxil-bellagio-glibc, libva-glibc, libxml2-glibc, libelf-glibc, libbz2-glibc, libclc-glibc"
TERMUX_PKG_BUILD_DEPENDS="llvm-glibc, libwayland-protocols-glibc, xorgproto-glibc, glslang-glibc"
TERMUX_PKG_PYTHON_COMMON_DEPS="mako, setuptools, pyyaml"
# disabling libunwind, microsoft-clc and valgrind will improve performance

TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-D android-libbacktrace=disabled
-D b_ndebug=true
-D dri3=enabled
-D gallium-drivers=
-D gallium-extra-hud=false
-D gallium-nine=false
-D gallium-va=disabled
-D gallium-vdpau=disabled
-D gallium-xa=disabled
-D gbm=disabled
-D libunwind=disabled
-D llvm=disabled
-D microsoft-clc=disabled
-D osmesa=false
-D platforms=x11,wayland
-D shared-glapi=disabled
-D xmlconfig=disabled
-D valgrind=disabled
-D opengl=false
"

termux_step_pre_configure() {
	case $TERMUX_ARCH in
		arm|aarch64) TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" -Dvulkan-drivers=wrapper";;
		*) TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" -Dvulkan-drivers=wrapper";;
	esac
	export MESON_PACKAGE_CACHE_DIR="${TERMUX_PKG_SRCDIR}"
	export LLVM_CONFIG=$TERMUX_PREFIX/bin/llvm-config

	echo "${TERMUX_PKG_VERSION}.termux-glibc-${TERMUX_PKG_REVISION:=0}" > ${TERMUX_PKG_SRCDIR}/VERSION
	rm ${TERMUX_PKG_SRCDIR}/subprojects/lua.wrap
	#sed -i "s|\"/dev/|\"${TERMUX_PREFIX}/dev/|g" $(grep -s -r -l '"/dev/')
}
