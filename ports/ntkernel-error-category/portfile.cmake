
if (VCPKG_CMAKE_SYSTEM_NAME)
    message(FATAL_ERROR "This port is only for building llfio on Windows Desktop")
endif()

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO "ned14/ntkernel-error-category"
    REF d6b8e9a544792518613d98668277be29dc322274
    SHA512 d9f6ac59ad3def3fcd9658439763fbaacf735b57283fb982ff5ea70089f0a32128e701546635a0f0ede5c5e5e53e8e87df81d45670a5ba6e077f0341602cdef9
    HEAD_REF master
)

file(REMOVE "${SOURCE_PATH}/CMakeLists.txt")
file(COPY "${CURRENT_PORT_DIR}/CMakeLists.txt" DESTINATION "${SOURCE_PATH}")

vcpkg_configure_cmake(
    SOURCE_PATH "${SOURCE_PATH}"
    PREFER_NINJA
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets()
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

# Handle copyright
file(INSTALL "${CURRENT_PORT_DIR}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
