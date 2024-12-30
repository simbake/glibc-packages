TERMUX_PKG_HOMEPAGE=https://www.mesa3d.org
TERMUX_PKG_DESCRIPTION="Android Vulkan wrapper Glibc"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_LICENSE_FILE="docs/license.rst"
TERMUX_PKG_MAINTAINER="xMeM <haooy@outlook.com>"
TERMUX_PKG_VERSION="24.3.1"
TERMUX_PKG_REVISION=4
TERMUX_PKG_SRCURL=git+https://github.com/xMeM/mesa
TERMUX_PKG_GIT_BRANCH=wrapper
_COMMIT=578ceaf21b23233f90d1b31add7a0dfdfb31b860
#TERMUX_PKG_DEPENDS="vulkan-headers-glibc, libwayland-protocols-glibc, libglvnd-glibc, gcc-libs-glibc, libdrm-glibc, libllvm-glibc, libexpat-glibc, zlib-glibc, zstd-glibc, libx11-glibc, libxcb-glibc, libxext-glibc, libxfixes-glibc, libxshmfence-glibc, libxxf86vm-glibc, libwayland-glibc, libvdpau-glibc, libomxil-bellagio-glibc, libva-glibc, libxml2-glibc, libelf-glibc, libbz2-glibc, libclc-glibc"
TERMUX_PKG_DEPENDS="vulkan-headers-glibc, vulkan-icd-loader-glibc, libdrm-glibc, libx11-glibc, libxcb-glibc, libxshmfence-glibc, libwayland-glibc, zlib-glibc, zstd-glibc"
TERMUX_PKG_BUILD_DEPENDS="libwayland-protocols-glibc, xorgproto-glibc, libxrandr-glibc"
TERMUX_PKG_PYTHON_COMMON_DEPS="mako, setuptools, pyyaml"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-Dandroid-libbacktrace=disabled
-Db_ndebug=true
-Dgbm=disabled
-Dopengl=false
-Dllvm=disabled
-Dshared-llvm=disabled
-Dplatforms=x11,wayland
-Dgallium-drivers=
-Dxmlconfig=disabled
-Dvulkan-drivers=wrapper
-Dlibunwind=disabled
-Dmicrosoft-clc=disabled
-Dvalgrind=disabled
-Dandroid-stub=false
"
termux_step_pre_configure() {
	export MESON_PACKAGE_CACHE_DIR="${TERMUX_PKG_SRCDIR}"
	export LLVM_CONFIG=$TERMUX_PREFIX/bin/llvm-config

	echo "${TERMUX_PKG_VERSION}.termux-glibc-${TERMUX_PKG_REVISION:=0}" > ${TERMUX_PKG_SRCDIR}/VERSION
	rm ${TERMUX_PKG_SRCDIR}/subprojects/lua.wrap
	#sed -i "s|\"/dev/|\"${TERMUX_PREFIX}/dev/|g" $(grep -s -r -l '"/dev/')
}
