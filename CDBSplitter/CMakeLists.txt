add_executable(CDBSplitter src/Main.cpp)
target_link_libraries(CDBSplitter PRIVATE reflectcpp::reflectcpp)

if (PROJECT_IS_TOP_LEVEL)
    target_check_formatting(CDBSplitter)
endif ()