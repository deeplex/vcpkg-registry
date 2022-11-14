
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO deeplex/concrete
    REF 941b63214ac0302b10213309f45ecbd59396ea82
    SHA512 380253b167771dea9d0fafbaa7d817fe422b8191be61475683c483193034bac49fdf785f84cb8d11c93fda8f9377151f1c98ab44d7f06fd66fff5eb70d6bad61
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
