
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO deeplex/concrete
    REF 165617ebfb4f788e22eda6d13b7c8523576bb5bd
    SHA512 556f4d89e4793341542e9d344541e51d39fbb8687134ef5a92abdf02431ae600a0b49265afe53bd847d55ff176b4a6a6e937af7b471545c2e7432b3d29edcf57
)

# Because concrete is a header-only library, the debug build is not necessary
set(VCPKG_BUILD_TYPE release)

vcpkg_cmake_configure(
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
        -DBUILD_TESTING=OFF
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/${PORT})
file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/lib"
)

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
