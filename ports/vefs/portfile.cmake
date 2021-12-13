
vcpkg_from_git(
    OUT_SOURCE_PATH SOURCE_PATH
    URL ssh://git@mdk-bs-dev02.test-server.ag:2224/native/vefs.git
    REF 48c2af3041624a6988e225ccde2a53e9049e9d6b # v0.4.0-alpha.4
    HEAD_REF develop
)
vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)

vcpkg_install_cmake()
vcpkg_fixup_cmake_targets(CONFIG_PATH cmake TARGET_PATH share/vefs)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/vefs RENAME copyright)
