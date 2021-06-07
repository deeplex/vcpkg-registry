
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO "deeplex-net/deeppack"
    REF 5f512b6ae9fd94036be5e7cc91ee52f68b034cdb
    SHA512 1d78dda27097fe644f1b27b8f2730ef0bff53bfe3c28bd03ccac78dd068895db1751957c6d767904b00b1ac08407539c6b6c3d29caf465a38329d1e059beac4e
    HEAD_REF master
    PATCHES
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
     -DBUILD_TESTING=OFF
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets()
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/deeppack RENAME copyright)
