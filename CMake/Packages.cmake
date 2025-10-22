if (CPM_SOURCE_CACHE)
    get_filename_component(CPM_DOWNLOAD_LOCATION "${CPM_SOURCE_CACHE}/cpm/CPM.cmake" ABSOLUTE)
else ()
    set(CPM_DOWNLOAD_LOCATION "${CMAKE_BINARY_DIR}/CPM.cmake")
endif ()

file(
    DOWNLOAD
    https://github.com/cpm-cmake/CPM.cmake/releases/download/v0.42.0/CPM.cmake
    ${CPM_DOWNLOAD_LOCATION}
    EXPECTED_HASH SHA256=2020b4fc42dba44817983e06342e682ecfc3d2f484a581f11cc5731fbe4dce8a
)
include(${CPM_DOWNLOAD_LOCATION})

set(CMAKE_EXPORT_COMPILE_COMMANDS OFF)

CPMAddPackage(
    NAME reflectcpp
    GITHUB_REPOSITORY getml/reflect-cpp
    GIT_TAG v0.20.0
)