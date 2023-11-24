
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO "deeplex/deeplog"
    REF "v${VERSION}"
    SHA512 0af341fb940eac3bcdac669813564d952d91e2517f1137f560cb5e0e9bdd53dc98ea34238c22112dfa52fa07ad0c455fed25405fee1aa36c18de2fc3ed4bd47c
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
