
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO "BurningEnlightenment/base64-cmake"
    REF 7170a90fe2065b3aed042ebe3f51fff7da73dfec
    SHA512 6a142e46bea2b68366138b0439e2effb87b4d1fbe51444ba6373553915e27ade6f6ed8fa19f3b509dfee196220e89a2e6a4c1d7044f10e5793ac00b1c227f975
    PATCHES
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
     -DBASE64_BUILD_TESTS=OFF
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets()
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/base64 RENAME copyright)
