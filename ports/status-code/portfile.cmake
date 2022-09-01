vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO ned14/status-code
    REF b4caedb9fd81ce4407ea57911222f77035f877a4
    SHA512 36b92de751f12dcf3747df8f0d8ff70dfe40ed7be538cdeb988c78858c37a648a2a9a1426cd9b20e98ae0e1b99cb2255dd7f7ef53db5d74b9eadd4969b64fa67
    HEAD_REF master
)

# Because status-code's deployed files are header-only, the debug build is not necessary
set(VCPKG_BUILD_TYPE release)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DPROJECT_IS_DEPENDENCY=On
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/status-code)

file(INSTALL "${CURRENT_PORT_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/Licence.txt")
