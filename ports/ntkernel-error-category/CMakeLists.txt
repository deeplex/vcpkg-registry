cmake_minimum_required(VERSION 3.15 FATAL_ERROR)
project(ntkernel-error-category VERSION 1.0 LANGUAGES CXX)

add_library(ntkernel-error-category src/ntkernel_category.cpp)
target_compile_features(ntkernel-error-category PUBLIC cxx_std_11)
target_include_directories(ntkernel-error-category PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>
)
target_compile_definitions(ntkernel-error-category PUBLIC
    $<$<NOT:$<BOOL:${BUILD_SHARED_LIBS}>>:NTKERNEL_ERROR_CATEGORY_STATIC>
    NTKERNEL_ERROR_CATEGORY_INLINE=0
)

include(GNUInstallDirs)

file(WRITE "${CMAKE_BINARY_DIR}/ntkernel-error-category-config.cmake" "include(\"\${CMAKE_CURRENT_LIST_DIR}/ntkernel-error-category-targets.cmake\")")
install(FILES "${CMAKE_BINARY_DIR}/ntkernel-error-category-config.cmake" DESTINATION "${CMAKE_INSTALL_DATADIR}/ntkernel-error-category/")

install(TARGETS ntkernel-error-category EXPORT ntkernel-error-category-targets)
install(FILES
    include/config.hpp
    include/ntkernel_category.hpp
    DESTINATION include/ntkernel-error-category
)
install(EXPORT ntkernel-error-category-targets NAMESPACE ntkernel-error-category:: DESTINATION "${CMAKE_INSTALL_DATADIR}/ntkernel-error-category/")
