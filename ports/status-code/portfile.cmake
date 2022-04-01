vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO ned14/status-code
    REF 42d3afaa388ae966938f558d9e00e390a2192fa8
    SHA512 f7965bfc702473be09a1d29da7e4c6241e481e609d57ff0ad989db7757e2d77b2b6fd1a89882961e8f16c405df97403710f1f3a3d3fd62341703b573d9035726
    HEAD_REF master
    PATCHES
        no-test.patch
        cxx_feature_level.patch
)

# Because status-code's deployed files are header-only, the debug build is not necessary
set(VCPKG_BUILD_TYPE release)

vcpkg_check_features(
    OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        cxx14 STATUS_CODE_REQUIRE_CXX14
        cxx20 STATUS_CODE_REQUIRE_CXX20
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        ${FEATURE_OPTIONS}
    MAYBE_UNUSED_VARIABLES
        STATUS_CODE_REQUIRE_CXX14 # not evaluated in case cxx20 is requested
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/status-code)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/lib")
file(RENAME "${CURRENT_PACKAGES_DIR}/include" "${CURRENT_PACKAGES_DIR}/include2")
file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/include")
file(RENAME "${CURRENT_PACKAGES_DIR}/include2" "${CURRENT_PACKAGES_DIR}/include/status-code")

file(INSTALL "${CURRENT_PORT_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
file(INSTALL "${SOURCE_PATH}/Licence.txt" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
