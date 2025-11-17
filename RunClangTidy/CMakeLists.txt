add_executable(RunClangTidy src/Main.cpp)
target_link_libraries(RunClangTidy PRIVATE reflectcpp::reflectcpp)

if (PROJECT_IS_TOP_LEVEL)
    target_check_formatting(RunClangTidy)
endif ()