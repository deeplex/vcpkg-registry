
if (VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
    set(BLAKE2_SHARED_OBJECT ON)
else()
    set(BLAKE2_SHARED_OBJECT OFF)
endif()

set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/libb2)
vcpkg_from_git(
    OUT_SOURCE_PATH SOURCE_PATH
    URL https://github.com/BurningEnlightenment/libb2.git
    REF ded229baabe4e526279052dc1cc0c3979880adac
    SHA512 76367e03f7506abf38dff1c62f7b09c4b0705879084ebf201b17261e93f23ee16b86470210548f39de9ce308ba7b2d99ce58e1781e40b1616ceeeae31136f767
    HEAD_REF master
)

vcpkg_configure_cmake(
    SOURCE_PATH "${SOURCE_PATH}"
    PREFER_NINJA
    OPTIONS
        -DBLAKE2_FAT_BINARIES=ON
        -DBLAKE2_SHARED_OBJECT=${BLAKE2_SHARED_OBJECT}
)

vcpkg_install_cmake()

vcpkg_copy_pdbs()

vcpkg_fixup_cmake_targets(CONFIG_PATH cmake)


list(APPEND DIRS_WITH_BINS "lib/Release" "debug/lib/Debug")
if (VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
    list(APPEND DIRS_WITH_BINS "bin/Release" "debug/bin/Debug")
endif()

# move the libraries one directory up
macro(fixup_target CONFIG PATH_PREFIX)
    string(TOLOWER "${CONFIG}" _TARGET_SUFFIX)
    set(_OUT_DIRS "lib")
    if (VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
        list(APPEND _OUT_DIRS "bin")
    endif()

    foreach(_OUT_DIR IN LISTS _OUT_DIRS)
        set(_DEST_DIR "${CURRENT_PACKAGES_DIR}/${PATH_PREFIX}${_OUT_DIR}")
        set(_SRC_DIR "${_DEST_DIR}/${CONFIG}")

        file(GLOB _BINS LIST_DIRECTORIES false RELATIVE "${_SRC_DIR}" "${_SRC_DIR}/libb2.*")

        foreach(_BIN IN LISTS _BINS)
            file(RENAME "${_SRC_DIR}/${_BIN}" "${_DEST_DIR}/${_BIN}")
        endforeach()

        file(REMOVE_RECURSE "${_SRC_DIR}")

        set(_TARGETPATH "${CURRENT_PACKAGES_DIR}/share/libb2/libb2-targets-${_TARGET_SUFFIX}.cmake")
        file(READ "${_TARGETPATH}" _CONTENT)
        string(REPLACE "/${_OUT_DIR}/${CONFIG}/libb2." "/${_OUT_DIR}/libb2." _CONTENT "${_CONTENT}")
        file(WRITE "${_TARGETPATH}" "${_CONTENT}")
    endforeach()
endmacro()
fixup_target("Debug" "debug/")
fixup_target("Release" "")

# remove duplicate include files
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

# Handle copyright
file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/libb2" RENAME copyright)
