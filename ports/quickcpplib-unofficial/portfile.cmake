
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO "ned14/quickcpplib"
    REF a47807c6b8ed0a4f2de7ffd8315a431de6d4278d
    SHA512 a20cbe526da9ddb30e0ffb898e990d682512a5540818f8330b0bd64eeac9358d1e2208659947300570be1da780494ba348036bffd97304a2132e0d74c1d6d68c
    HEAD_REF master
    PATCHES
        "backtrace-include-fix.patch"
        "gsl-include-fix.patch"
        "signal-guard-abi.patch"
)

file(REMOVE "${SOURCE_PATH}/CMakeLists.txt")
file(COPY
    "${CURRENT_PORT_DIR}/CMakeLists.txt"
    "${CURRENT_PORT_DIR}/quickcpplib-unofficial-config.cmake.in"
    DESTINATION "${SOURCE_PATH}"
)
if (EXISTS "${SOURCE_PATH}/include/quickcpplib/detail/impl/signal_guard.ipp")
    file(RENAME "${SOURCE_PATH}/include/quickcpplib/detail/impl/signal_guard.ipp" "${SOURCE_PATH}/include/signal_guard.cpp")
    file(RENAME "${SOURCE_PATH}/include/quickcpplib/detail/impl/execinfo_win64.ipp" "${SOURCE_PATH}/include/execinfo_win64.cpp")
endif()

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets()
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

# Handle copyright
file(INSTALL "${SOURCE_PATH}/Licence.txt" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
