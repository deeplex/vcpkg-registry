
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO "deeplex-net/deeppack"
    REF 888930fd30306feb704bde70486b75fd7b5f6624
    SHA512 0863b25a4a42d914431fdeb4b45afb35f5c28e9cd86da2b340d27891b60de1a8bb0efe546439f16bc9325d5fbafd9cdacf2efe99658d0e480a39c413c2ce78bd
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
