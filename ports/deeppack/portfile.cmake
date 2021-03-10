
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO "deeplex-net/deeppack"
    REF 037f87a30b341073f3d7c4c2d09f7030d684bef4
    SHA512 0e17d6f25c726f46bba8b0be34eb88e3bdd94e3a8c620252c479d0ad466f0ac9575932095f089652a790fc87b0109a96b9c177e58324cc4fed909b9aadf6d8f7
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
