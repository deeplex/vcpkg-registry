
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO "ned14/quickcpplib"
    REF 24d92c71ef5d2200f7e42bc47e6dd59ad6d99fe3
    SHA512 9e39237833dea8288fbc5fda4189d971dff76284e3f352c7a0762e71a4bf311f4550fefd0f8926b6d971ca1c62acc3d055af233912de0adb0c6821995b6ce7e7
    HEAD_REF master
    PATCHES
        #"backtrace-include-fix.patch"
        "gsl-include-fix.patch"
        #"signal-guard-abi.patch"
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
