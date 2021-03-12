
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO "ned14/llfio"
    REF a74411eddb6401ab884c5f92cccc24b9a64a9e6f
    SHA512 e0f8b030ac995c24135aae89450f05ad75e5fed10caec254b327f1fc0d4c23eaeb53b7859e5e5b4731ffeace9fdfc75cd04a66025243e7f35c7dea37dc0d1b6c
    HEAD_REF master
    PATCHES
        disable-module-imports.patch
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
