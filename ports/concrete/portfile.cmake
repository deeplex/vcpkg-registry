
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO deeplex/concrete
    REF bd347d0e3fb59f1ad8e1b99ad11bed1f58d15bca
    SHA512 132be0ef7f7cf801333a29edbd8491e88eb2f37422bf7ddab2b9d49818633c35d6f01d6534862eebc6dac46b14e0ec6100d06f5512ff3833673fa14dad8491bb
)

# Because concrete is a header-only library, the debug build is not necessary
set(VCPKG_BUILD_TYPE release)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_TESTING=OFF
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/${PORT})
file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/lib"
)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
