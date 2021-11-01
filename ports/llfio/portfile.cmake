message(WARNING [=[
LLFIO depends on Outcome which depends on QuickCppLib which uses the vcpkg versions of gsl-lite and byte-lite, rather than the versions tested by QuickCppLib's, Outcome's and LLFIO's CI. It is not guaranteed to work with other versions, with failures experienced in the past up-to-and-including runtime crashes. See the warning message from QuickCppLib for how you can pin the versions of those dependencies in your manifest file to those with which QuickCppLib was tested. Do not report issues to upstream without first pinning the versions as QuickCppLib was tested against.
]=])


vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO ned14/llfio
    REF 721503d32fe35dbaa93bde0214ae8cd3799d14b8
    SHA512 b017a0fddcd3e53c22d9863454e7ad4ce364d9e4fa46cd909ceb395df57052b5d4334081a3405e1248452863c451c3174dc7eaab70907dc8d22f4db67930cbd5
    HEAD_REF develop
    PATCHES
        msvc-19.29.30136.0.patch
        msvc-crt-linkage.patch
)

vcpkg_from_github(
    OUT_SOURCE_PATH NTKEC_SOURCE_PATH
    REPO ned14/ntkernel-error-category
    REF bbd44623594142155d49bd3ce8820d3cf9da1e1e
    SHA512 589d3bc7bca98ca8d05ce9f5cf009dd98b8884bdf3739582f2f6cbf5a324ce95007ea041450ed935baa4a401b4a0242c181fb6d2dcf7ad91587d75f05491f50e
    HEAD_REF master
)

vcpkg_check_features(
    OUT_FEATURE_OPTIONS LLFIO_FEATURE_OPTIONS
    FEATURES
      status-code LLFIO_USE_EXPERIMENTAL_SG14_STATUS_CODE
)

# LLFIO needs a copy of QuickCppLib with which to bootstrap its cmake
file(COPY "${CURRENT_INSTALLED_DIR}/include/quickcpplib"
    DESTINATION "${SOURCE_PATH}/quickcpplib/repo/include/"
)
file(COPY "${CURRENT_INSTALLED_DIR}/share/ned14-internal-quickcpplib/"
    DESTINATION "${SOURCE_PATH}/quickcpplib/repo/"
)

# LLFIO expects ntkernel-error-category to live inside its include directory
file(REMOVE_RECURSE "${SOURCE_PATH}/include/llfio/ntkernel-error-category")
file(RENAME "${NTKEC_SOURCE_PATH}" "${SOURCE_PATH}/include/llfio/ntkernel-error-category")

set(extra_config)
# cmake does not correctly set CMAKE_SYSTEM_PROCESSOR when targeting ARM on Windows
if(VCPKG_TARGET_IS_WINDOWS AND (VCPKG_TARGET_ARCHITECTURE STREQUAL "arm" OR VCPKG_TARGET_ARCHITECTURE STREQUAL "arm64"))
  list(APPEND extra_config -DLLFIO_ASSUME_CROSS_COMPILING=On)
endif()

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DCMAKE_CXX_STANDARD=20
        -DPROJECT_IS_DEPENDENCY=On
        -Dquickcpplib_DIR=${CURRENT_INSTALLED_DIR}/share/ned14-internal-quickcpplib
        ${LLFIO_FEATURE_OPTIONS}
        -DLLFIO_ENABLE_DEPENDENCY_SMOKE_TEST=ON  # Leave this always on to test everything compiles
        -DCMAKE_DISABLE_FIND_PACKAGE_Git=ON
        ${extra_config}
)

# LLFIO install requires that the static library is always built;
# in addition to that the dynamic library would always be build during install anyways
vcpkg_cmake_build(TARGET _sl LOGFILE_BASE build-sl)
vcpkg_cmake_build(TARGET _dl LOGFILE_BASE build-dl)

if("run-tests" IN_LIST FEATURES)
    vcpkg_cmake_build(TARGET test LOGFILE_BASE test)
endif()

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/llfio)

if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
    set(EXPORTS_PATH "${CURRENT_PACKAGES_DIR}/share/${PORT}/llfioExports.cmake")
    file(READ ${EXPORTS_PATH} contents)

    string(REGEX REPLACE
[[ Cleanup temporary variables\.
set\(_IMPORT_PREFIX\)
]]
[[ Cleanup temporary variables.
set(_IMPORT_PREFIX)
list(FILTER _IMPORT_CHECK_TARGETS EXCLUDE REGEX "dl$")
]]
        contents "${contents}"
    )

    file(WRITE ${EXPORTS_PATH} "${contents}")
endif()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include" "${CURRENT_PACKAGES_DIR}/debug/share")
if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/bin" "${CURRENT_PACKAGES_DIR}/debug/bin")
endif()

if("status-code" IN_LIST FEATURES)
    file(INSTALL "${CURRENT_PORT_DIR}/usage-status-code-${VCPKG_LIBRARY_LINKAGE}" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
else()
    file(INSTALL "${CURRENT_PORT_DIR}/usage-error-code-${VCPKG_LIBRARY_LINKAGE}" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
endif()
file(INSTALL "${SOURCE_PATH}/Licence.txt" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
