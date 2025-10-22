add_executable(RunClangTidy src/Main.cpp)
target_link_libraries(RunClangTidy PRIVATE reflectcpp::reflectcpp)

target_check_formatting(RunClangTidy)