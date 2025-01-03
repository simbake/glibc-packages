TERMUX_PKG_HOMEPAGE="https://www.mesa3d.org"
TERMUX_PKG_DESCRIPTION="An open-source implementation of the OpenGL specification"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_LICENSE_FILE="docs/license.rst"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION="24.2.6"
TERMUX_PKG_SRCURL=https://mesa.freedesktop.org/archive/mesa-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=2b68c4a6f204c1999815a457299f81c41ba7bf48c4674b0b2d1d8864f41f3709
TERMUX_PKG_DEPENDS="vulkan-icd-loader-glibc, libwayland-protocols-glibc, libglvnd-glibc, gcc-libs-glibc, libdrm-glibc, libllvm-glibc, libexpat-glibc, zlib-glibc, zstd-glibc, libx11-glibc, libxcb-glibc, libxext-glibc, libxfixes-glibc, libxshmfence-glibc, libxxf86vm-glibc, libwayland-glibc, libvdpau-glibc, libomxil-bellagio-glibc, libva-glibc, libxml2-glibc, libelf-glibc, libbz2-glibc, libclc-glibc"
TERMUX_PKG_SUGGESTS="mesa-dev-glibc"
TERMUX_PKG_BUILD_DEPENDS="llvm-glibc, libwayland-protocols-glibc, xorgproto-glibc, glslang-glibc, vulkan-headers-glibc"
TERMUX_PKG_PYTHON_COMMON_DEPS="mako, setuptools, pyyaml"
# disabling libunwind, microsoft-clc and valgrind will improve performance

TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-Dgallium-drivers=zink,swrast,virgl \
-Dvulkan-drivers= \
-Ddri-drivers= \
-Dplatforms=x11,wayland
"

termux_step_pre_configure() {
	case $TERMUX_ARCH in
		arm|aarch64) TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" -Dvulkan-drivers=virtio";;
		*) TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" -Dvulkan-drivers=virtio";;
	esac
	export MESON_PACKAGE_CACHE_DIR="${TERMUX_PKG_SRCDIR}"
	export LLVM_CONFIG=$TERMUX_PREFIX/bin/llvm-config

	echo "${TERMUX_PKG_VERSION}.termux-glibc-${TERMUX_PKG_REVISION:=0}" > ${TERMUX_PKG_SRCDIR}/VERSION
	rm ${TERMUX_PKG_SRCDIR}/subprojects/lua.wrap
	#sed -i "s|\"/dev/|\"${TERMUX_PREFIX}/dev/|g" $(grep -s -r -l '"/dev/')
}
