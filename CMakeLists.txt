cmake_minimum_required(VERSION 3.27)

project(CMakeUtils
    DESCRIPTION "Reusable CMake functions and targets for C/C++ projects"
    HOMEPAGE_URL "https://github.com/Floris0106/CMakeUtils"
    LANGUAGES C CXX
)

set(GENERATOR_SUPPORTS_CDB OFF)
if (${CMAKE_GENERATOR} MATCHES "^.*(Ninja|Make).*$")
    set(GENERATOR_SUPPORTS_CDB ON)
endif ()

include(CMakeDependentOption)

option(UTILS_ENABLE_FORMATTING "Enable formatting checking targets using clang-format" ON)
cmake_dependent_option(UTILS_ENABLE_STATIC_ANALYSIS "Enable static analysis targets using clang-tidy" ON ${GENERATOR_SUPPORTS_CDB} OFF)

include(CMake/Utils.cmake)
include(CMake/Formatting.cmake)

if (NOT UTILS_ENABLE_STATIC_ANALYSIS)
    return()
endif ()

include(CMake/Packages.cmake)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ${PROJECT_IS_TOP_LEVEL})

if (NOT ${PROJECT_IS_TOP_LEVEL})
    add_compile_options(-O3)
endif ()

if (${CMAKE_GENERATOR} STREQUAL "Ninja Multi-Config")
    add_subdirectory(CDBSplitter)
endif ()
add_subdirectory(RunClangTidy)

include(CMake/StaticAnalysis.cmake)