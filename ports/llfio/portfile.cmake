
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO "ned14/llfio"
    REF 17a15470b8d079625732bccfc96a3dd45e18f1c1
    SHA512 2b39ea89e76267cff0875827f79d8261f990433ff3c449fb356cdc13b4f5836be9574fceff9c24d81d70c5cabe355baf54c33357642c12f2929605bc53a27ba4
    HEAD_REF master
    PATCHES
)

file(REMOVE "${SOURCE_PATH}/CMakeLists.txt")
file(COPY
    "${CURRENT_PORT_DIR}/CMakeLists.txt"
    "${CURRENT_PORT_DIR}/llfio-config.cmake.in"
    DESTINATION "${SOURCE_PATH}")

vcpkg_configure_cmake(
    SOURCE_PATH "${SOURCE_PATH}"
    PREFER_NINJA
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets()
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

# Handle copyright
file(INSTALL "${SOURCE_PATH}/Licence.txt" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
