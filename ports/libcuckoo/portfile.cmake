# Header-only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO efficient/libcuckoo
    REF 784d0f5d147b9a73f897ae55f6c3712d9a91b058
    SHA512 64e04b4ecea71034fbe7308fa6a16b29f92dc943246de7a87c81c08a8d27ea7d76ce1329276b423bc0fb1157614406751ef1ed6a45ed045a70c5494d343dcf23
    HEAD_REF master
)

vcpkg_cmake_configure(
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
        -DBUILD_EXAMPLES=OFF
        -DBUILD_TESTS=OFF
        -DBUILD_STRESS_TESTS=OFF
        -DBUILD_UNIT_TESTS=OFF
        -DBUILD_UNIVERSAL_BENCHMARK=OFF
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(CONFIG_PATH share/cmake/${PORT})

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug)

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
