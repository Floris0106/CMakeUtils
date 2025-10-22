add_executable(CDBSplitter src/Main.cpp)
target_link_libraries(CDBSplitter PRIVATE reflectcpp::reflectcpp)

target_check_formatting(CDBSplitter)