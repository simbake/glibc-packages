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
TERMUX_PKG_API_LEVEL=26
TERMUX_PKG_DEPENDS="vulkan-headers-glibc, vulkan-icd-loader-glibc, libdrm-glibc, libx11-glibc, libxcb-glibc, libxshmfence-glibc, libwayland-glibc, zlib-glibc, zstd-glibc"
TERMUX_PKG_BUILD_DEPENDS="libwayland-protocols-glibc, xorgproto-glibc, libxrandr-glibc"
TERMUX_PKG_PYTHON_COMMON_DEPS="mako, setuptools, pyyaml"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-Dandroid-libbacktrace=disabled
-D b_ndebug=true
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
termux_step_post_get_source() {
	git fetch --unshallow
	git checkout $_COMMIT
	# Do not use meson wrap projects
	rm -rf subprojects
}
termux_step_pre_configure() {
    termux_setup_cmake

    # Add GNU-specific macro definition
    CPPFLAGS+=" -D__USE_GNU"
    
    # Optional: Adjust LDFLAGS for glibc (e.g., threading)
    LDFLAGS+=" -pthread"

    # Set up wrapper binary directory
    _WRAPPER_BIN=$TERMUX_PKG_BUILDDIR/_wrapper/bin
    mkdir -p $_WRAPPER_BIN
    
    if [ "$TERMUX_ON_DEVICE_BUILD" = "false" ]; then
        # Replace CMake wrapper logic for cross-compilation
        sed 's|@CMAKE@|'"$(command -v cmake)"'|g' \
            $TERMUX_PKG_BUILDER_DIR/cmake-wrapper.in \
            > $_WRAPPER_BIN/cmake
        chmod 0700 $_WRAPPER_BIN/cmake
    fi

    # Export the wrapper binary directory to PATH
    export PATH=$_WRAPPER_BIN:$PATH
}

termux_step_post_configure() {
    # Cleanup the custom CMake wrapper
    rm -f $_WRAPPER_BIN/cmake
}
