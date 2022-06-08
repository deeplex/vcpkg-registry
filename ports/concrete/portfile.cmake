
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO deeplex/concrete
    REF v0.0.0-alpha.2
    SHA512 6ce6d88eb9d2d878c022f829180ec67b97c4deb218ca3990a59b59c9f29ed583857208b934e233edf5070337038143f46552462d0393ba18885b9cea13142e59
)

# Because status-code's deployed files are header-only, the debug build is not necessary
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
