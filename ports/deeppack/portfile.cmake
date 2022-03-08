
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO "deeplex/deeppack"
    REF v0.0.0-alpha.1
    SHA512 09348842098e53e91bb90de946d812ca286f2b833ec504d9f890fca5ab497eb3b8d33e9e83e3c83ffc60918e009c92419f4a61af7c7f66c5e18655e31a5ff7cf
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
