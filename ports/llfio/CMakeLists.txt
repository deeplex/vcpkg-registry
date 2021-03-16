cmake_minimum_required(VERSION 3.15 FATAL_ERROR)
project(llfio VERSION 2.0.0.0 LANGUAGES CXX)

set(CMAKE_CXX_EXTENSIONS OFF)

if (WIN32)
    find_package(ntkernel-error-category CONFIG REQUIRED)
endif()

find_package(quickcpplib-unofficial CONFIG REQUIRED)
find_package(outcome CONFIG REQUIRED)

add_library(llfio src/llfio.cpp)
target_compile_definitions(llfio
    PUBLIC
        LLFIO_EXPERIMENTAL_STATUS_CODE=0
        LLFIO_DISABLE_ABI_PERMUTATION=1
        LLFIO_DISABLE_CXX_MODULES=1

    INTERFACE
        LLFIO_HEADERS_ONLY=0

    PRIVATE
        LLFIO_SOURCE=1
)
if (NOT BUILD_SHARED_LIBS)
    target_compile_definitions(llfio PUBLIC LLFIO_STATIC_LINK=1)
endif()

target_include_directories(llfio PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>
)
target_compile_features(llfio PUBLIC cxx_std_20)
target_link_libraries(llfio PUBLIC
    quickcpplib::quickcpplib
    outcome::outcome
)

if (WIN32)
    target_compile_definitions(llfio
        PRIVATE
            _SILENCE_CXX17_ITERATOR_BASE_CLASS_DEPRECATION_WARNING
            _UNICODE
            UNICODE
    )
    target_link_libraries(llfio
        PUBLIC
            ntkernel-error-category::ntkernel-error-category
    )
endif()

include(GNUInstallDirs)

include(CMakePackageConfigHelpers)
configure_package_config_file("${CMAKE_SOURCE_DIR}/llfio-config.cmake.in"
    "${CMAKE_BINARY_DIR}/llfio-config.cmake"

    INSTALL_DESTINATION "${CMAKE_INSTALL_DATADIR}/llfio"
)
install(FILES "${CMAKE_BINARY_DIR}/llfio-config.cmake" DESTINATION "${CMAKE_INSTALL_DATADIR}/llfio/")

install(TARGETS llfio EXPORT llfio-targets)
install(DIRECTORY include/ DESTINATION include FILES_MATCHING
    PATTERN "*.h"
    PATTERN "*.hpp"
    PATTERN "*.natvis"
    PATTERN "*ntkernel-error-category" EXCLUDE
    PATTERN "detail" EXCLUDE
)
install(EXPORT llfio-targets NAMESPACE llfio:: DESTINATION "${CMAKE_INSTALL_DATADIR}/llfio/")
