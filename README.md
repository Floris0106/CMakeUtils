# CMakeUtils

This repository contains some reusable utility functions and targets for CMake projects.

## Usage

To use these utilities in you CMake project, you can either use [CPM.cmake](https://github.com/TheLartians/CPM.cmake)
(recommended) or `FetchContent` to include the repository as a subproject. You can use the following snippet:

```cmake
CPMAddPackage(
    NAME CMakeUtils
    GITHUB_REPOSITORY Floris0106/CMakeUtils
    GIT_TAG v1.0.0
)
```

You can also set the `UTILS_ENABLE_FORMATTING` and `UTILS_ENABLE_STATIC_ANALYSIS` options here, which will be explained later.

## Available functions

### `start_timer` and `stop_timer`

The `start_timer` and `stop_timer` functions can be used to measure the time taken by a section of code. You can call
`start_timer()` to start the timer, and `stop_timer(time)` to stop the timer and format the output into the variable `time`.

### `target_get_sources`\*

This function can be used to get the source files of a target. For example:

```cmake
add_library(MyLibrary STATIC src1.cpp src2.cpp)
target_get_sources(MyLibrary SOURCES)
message(${SOURCES})
```

will output the absolute paths of `src1.cpp` and `src2.cpp`.

### `target_check_formatting`\*

If `UTILS_ENABLE_FORMATTING` is enabled, the `target_check_formatting` function will be enabled. This function can be called
with a single target as an argument. It will add two targets using clang-format: <target>-CheckFormatting will check the
target's sources for formatting issues, and <target>-FixFormatting will fix any formatting issues found. Additionally, the
targets All-CheckFormatting and All-FixFormatting will be created, which will run formatting on all targets. If clang-format
is not installed, a warning will be printed and the function will do nothing.

### Notes

\* These functions should only be called from same CMakeLists.txt where the target is defined.

## Available targets

If `UTILS_ENABLE_STATIC_ANALYSIS` is enabled and clang-tidy is installed, the StaticAnalysis target will be created. This
target will run clang-tidy on all targets in the project for which the `EXPORT_COMPILE_COMMANDS` property is set. If
`UTILS_ENABLE_STATIC_ANALYSIS` is enabled but clang-tidy is not installed, a warning will be printed and the target will not 
be created. Note that this feature is only supported when using Ninja, Ninja Multi-Config, or a Makefile generator.

## License

© Floris van Onna, 2025

Available under the 3-Clause BSD License. See [LICENSE](./LICENSE) for details.