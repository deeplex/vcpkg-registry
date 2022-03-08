
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO deeplex/concrete
    REF 9ce255f9d1b3b01deb6d82246711aa2e54774e22
    SHA512 6ed241c52374699f3a00dbc99dacd3834d3a196db8e92c531fa6e7006a53e44c5a6b9f193e3f5968bd2157576bdec0c6472c3b144122c1e4dbd3a83e9e8032cd
)

vcpkg_cmake_configure(
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
        -DBUILD_TESTING=OFF
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/concrete)
file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/debug"
    "${CURRENT_PACKAGES_DIR}/lib"
)

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/concrete RENAME copyright)
