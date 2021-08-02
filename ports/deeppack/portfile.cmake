
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO "deeplex-net/deeppack"
    REF 954685774a3052c52ca799b2c6432a6cfc7ee83c
    SHA512 bd8fb23b0ff7da8a517e424dad10ad5cc81cd6fcadc2ec3b1c8c13f73755194ea7b0ea998413b79f26ba5ef615a21d4d7e0cc4fb861e7263c447f6d2a376d0d7
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
