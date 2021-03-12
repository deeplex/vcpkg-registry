cmake_minimum_required(VERSION 3.15 FATAL_ERROR)
project(quickcpplib VERSION 0.1.0.0 LANGUAGES CXX)

find_package(Threads)

add_library(quickcpplib include/signal_guard.cpp)
target_compile_definitions(quickcpplib
    PUBLIC
        $<$<NOT:$<BOOL:${BUILD_SHARED_LIBS}>>:QUICKCPPLIB_STATIC_LINK>

        QUICKCPPLIB_HEADERS_ONLY=0
        QUICKCPPLIB_USE_STD_BYTE=1
        QUICKCPPLIB_USE_STD_OPTIONAL=1
        QUICKCPPLIB_USE_STD_SPAN=1

    PRIVATE
        $<$<BOOL:${BUILD_SHARED_LIBS}>:QUICKCPPLIB_EXPORTS>
)

target_include_directories(quickcpplib INTERFACE
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>
)

target_compile_features(quickcpplib PUBLIC cxx_std_17)
target_link_libraries(quickcpplib PUBLIC Threads::Threads)

if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
    # On Linux, things using me must link to libdl
    target_link_libraries(quickcpplib PUBLIC dl)

elseif(CMAKE_SYSTEM_NAME STREQUAL "FreeBSD")
    # On FreeBSD, things using me must link to libexecinfo
    target_link_libraries(quickcpplib PUBLIC execinfo)

elseif (CMAKE_SYSTEM_NAME STREQUAL "Windows")
    # On Windows, some SDK flags are needed and we add a libexecinfo shim
    target_compile_definitions(quickcpplib
        PRIVATE
            WIN32_LEAN_AND_MEAN
            VC_EXTRALEAN
            _UNICODE
            UNICODE
    )
    target_sources(quickcpplib PRIVATE include/execinfo_win64.cpp)
endif()

include(GNUInstallDirs)

include(CMakePackageConfigHelpers)
configure_package_config_file(quickcpplib-unofficial-config.cmake.in
    "${CMAKE_BINARY_DIR}/quickcpplib-unofficial-config.cmake"

    INSTALL_DESTINATION "${CMAKE_INSTALL_DATADIR}/quickcpplib-unofficial"
)
install(FILES "${CMAKE_BINARY_DIR}/quickcpplib-unofficial-config.cmake" DESTINATION "${CMAKE_INSTALL_DATADIR}/quickcpplib-unofficial/")

install(TARGETS quickcpplib EXPORT quickcpplib-targets)

install(DIRECTORY include/quickcpplib
    TYPE INCLUDE
    FILES_MATCHING
    PATTERN "*.h"
    PATTERN "*.hpp"
    PATTERN "*.natvis"
    PATTERN "boost*" EXCLUDE
    PATTERN "byte" EXCLUDE
    PATTERN "detail/impl" EXCLUDE
    PATTERN "gsl-lite*" EXCLUDE
    PATTERN "optional" EXCLUDE
)
install(EXPORT quickcpplib-targets NAMESPACE quickcpplib:: DESTINATION "${CMAKE_INSTALL_DATADIR}/quickcpplib-unofficial/")
