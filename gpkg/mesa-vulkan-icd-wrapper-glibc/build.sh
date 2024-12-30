TERMUX_PKG_HOMEPAGE=https://www.mesa3d.org
TERMUX_PKG_DESCRIPTION="Android Vulkan wrapper Glibc"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_LICENSE_FILE="docs/license.rst"
TERMUX_PKG_MAINTAINER="xMeM <haooy@outlook.com>"
TERMUX_PKG_VERSION="24.3.1"
TERMUX_PKG_REVISION=4
TERMUX_PKG_SRCURL=git+https://github.com/simbake/mesa
TERMUX_PKG_GIT_BRANCH=wrapper
_COMMIT=578ceaf21b23233f90d1b31add7a0dfdfb31b860
TERMUX_PKG_DEPENDS="vulkan-headers-glibc, libwayland-protocols-glibc, libglvnd-glibc, gcc-libs-glibc, libdrm-glibc, libllvm-glibc, libexpat-glibc, zlib-glibc, zstd-glibc, libx11-glibc, libxcb-glibc, libxext-glibc, libxfixes-glibc, libxshmfence-glibc, libxxf86vm-glibc, libwayland-glibc, libvdpau-glibc, libomxil-bellagio-glibc, libva-glibc, libxml2-glibc, libelf-glibc, libbz2-glibc, libclc-glibc"
TERMUX_PKG_BUILD_DEPENDS="libwayland-protocols-glibc, xorgproto-glibc, libxrandr-glibc, glslang-glibc"

TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-Dcpp_rtti=false
-Dgbm=disabled
-Dopengl=false
-Dllvm=disabled
-Dshared-llvm=disabled
-Dplatforms=x11,wayland
-Dgallium-drivers=
-Dxmlconfig=disabled
-Dvulkan-drivers=wrapper
"
