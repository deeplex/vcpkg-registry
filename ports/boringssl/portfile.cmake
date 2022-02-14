
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
    REF 3a667d10e94186fd503966f5638e134fe9fb4080
    PATCHES
        cmake.patch
        warnings.patch
)

vcpkg_cmake_configure(
    SOURCE_PATH ${SOURCE_PATH}
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup()
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/boringssl RENAME copyright)

vcpkg_copy_pdbs()
