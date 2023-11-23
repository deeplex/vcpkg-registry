
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO "deeplex/deeplog"
    REF f7c3e24017e19f5765cdfbeba6add3961785eef0
    SHA512 6e84f7d51e3e40da69e9ef54879ccc59b996d4d90a549739bfe3bfb5f1be7f57b2fbba0c3411a28241fcbbff5840cb9797f4592d4aee49c17da7fc98cf08d86f
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
