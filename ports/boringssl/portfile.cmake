
macro(add_program_env WHICH)
    vcpkg_find_acquire_program(${WHICH})
    get_filename_component(_boringssl_TOOLPATH "${${WHICH}}" DIRECTORY)
    vcpkg_add_to_path(PREPEND "${_boringssl_TOOLPATH}")
endmacro()

add_program_env(GO)
add_program_env(NINJA)
add_program_env(PERL)
add_program_env(NASM)

vcpkg_from_git(
    OUT_SOURCE_PATH SOURCE_PATH
    URL https://boringssl.googlesource.com/boringssl
    REF 8e8f250422663106d478f6927beefba289a95b37
    SHA512 4d544d84770c9b5b889ec6c76e24b6bcfea7316b856fe47e86de0486aeb6d821854136da0c16d6970f42ee262f75de56b5541af9e22565b0bf5c38edc855483b
    PATCHES
        cmake.patch
        vs16.6_warnings.patch
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)

vcpkg_install_cmake()
vcpkg_fixup_cmake_targets(CONFIG_PATH cmake)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/boringssl RENAME copyright)

vcpkg_copy_pdbs()
