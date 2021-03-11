
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO "ned14/llfio"
    REF e8f25ff3646124c4090a3413bfb43751b680a3ff
    SHA512 4ad5d7da04286af5c7bc1425734771acdf4d36a0042c2e2ad69bdfdec7d9d5c42f73e4fef526eaa100666080ec41b3d252f87634a06a08223682de95798c642f
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
