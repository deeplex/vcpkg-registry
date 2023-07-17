
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO "deeplex/deeplog"
    REF "v${VERSION}"
    SHA512 6069720f0947e93e906aca83334e06fdae9b5a55aac09774b87bf18098b5569ecb8d9e841968689f405e22c2d7450d55de467ed34065faca3838891732d6abca
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_TESTING=OFF
        -DWARNINGS_AS_ERRORS=OFF
        "-DCMAKE_INSTALL_INCLUDEDIR=${CURRENT_PACKAGES_DIR}/include"
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/${PORT})

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
