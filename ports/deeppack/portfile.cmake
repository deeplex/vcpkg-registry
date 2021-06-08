
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO "deeplex-net/deeppack"
    REF 21be99bf25615da7df66bb391ea511f13c35671d
    SHA512 4f924711707f520549f15c8667829338db32aa830a52131191b564b4cf4fc6bfa41b5884f866acacd9ee5e10ba1b1c2d30c4990cafd966f67f19b28727ee8a1d
    HEAD_REF master
    PATCHES
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
     -DBUILD_TESTING=OFF
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets()
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/deeppack RENAME copyright)
