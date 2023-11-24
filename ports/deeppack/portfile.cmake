
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO "deeplex/deeppack"
    REF "v${VERSION}"
    SHA512 e8d09d783db698a1ca34a8029dadfa7454a96080537292b7a0302a5a883de5002e7131951a775246d3d38b5ffcdf6ad2fa028fa46cdfaf9f6fe818fa9841a97e
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
