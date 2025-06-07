
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO "deeplex/concrete"
    REF "v${VERSION}"
    SHA512 48f7d499b7b9d47c2028d6b4b4cf5d1b39da4c9c22c00ee48103709d29805e2ee7c961d71154ff19fcbfc40f7955b87b66115afe7e98f40f996937be73e0a1e2
)

# Because concrete is a header-only library, the debug build is not necessary
set(VCPKG_BUILD_TYPE release)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_TESTING=OFF
        -DWARNINGS_AS_ERRORS=OFF
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/${PORT})
file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/lib"
)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
