cmake_minimum_required(VERSION 3.15 FATAL_ERROR)
project(outcome VERSION 2.2.0 LANGUAGES CXX)

find_package(quickcpplib-unofficial CONFIG REQUIRED)

add_library(outcome INTERFACE)
target_include_directories(outcome INTERFACE
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>
)
target_compile_definitions(outcome INTERFACE
    OUTCOME_DISABLE_ABI_PERMUTATION=1
)
target_compile_features(outcome INTERFACE
    cxx_alias_templates
    cxx_variadic_templates
    cxx_variable_templates # msvc support?
    cxx_noexcept
    cxx_constexpr
    cxx_lambda_init_captures
    cxx_attributes
    cxx_generic_lambdas
)
target_link_libraries(outcome INTERFACE
    quickcpplib::quickcpplib
)

include(GNUInstallDirs)

include(CMakePackageConfigHelpers)
configure_package_config_file(outcome-config.cmake.in
    "${CMAKE_BINARY_DIR}/outcome-config.cmake"

    INSTALL_DESTINATION "${CMAKE_INSTALL_DATADIR}/outcome"
)
install(FILES "${CMAKE_BINARY_DIR}/outcome-config.cmake" DESTINATION "${CMAKE_INSTALL_DATADIR}/outcome/")

install(TARGETS outcome EXPORT outcome-targets)

install(DIRECTORY include/
    TYPE INCLUDE
    FILES_MATCHING
    PATTERN "*.h"
    PATTERN "*.hpp"
    PATTERN "*.ipp"
    PATTERN "*.natvis"
    PATTERN "outcome/experimental" EXCLUDE
)
install(EXPORT outcome-targets NAMESPACE outcome:: DESTINATION "${CMAKE_INSTALL_DATADIR}/outcome/")
