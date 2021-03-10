
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO ned14/outcome
    REF 10f1a124ab7d2e1d75ee31138e3b06c01f84ca5c
    SHA512 82706b9901a3613ccc757a79edcf8cac7ec9d51c5d04bad1644dccc79688010eb0eb2fcd1fba050dfdbaf4c66304d6db297bac4e74e8c1caab0733b32c77a52d
    HEAD_REF master
    PATCHES
)

file(REMOVE "${SOURCE_PATH}/CMakeLists.txt")
file(COPY
    "${CURRENT_PORT_DIR}/CMakeLists.txt"
    "${CURRENT_PORT_DIR}/outcome-config.cmake.in"
    DESTINATION "${SOURCE_PATH}"
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets()
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")

# Handle copyright
file(INSTALL "${SOURCE_PATH}/Licence.txt" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
