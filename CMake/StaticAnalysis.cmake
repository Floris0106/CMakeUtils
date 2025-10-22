find_program(CLANG_TIDY_BIN clang-tidy)

if (NOT CLANG_TIDY_BIN)
    message(STATUS "clang-tidy not found, static analysis checks are disabled")
    return()
endif ()

if (${CMAKE_GENERATOR} STREQUAL "Ninja Multi-Config")

    set(CDB_FILE $<CONFIG>_compile_commands.json)

    set(CDB_FILES "")
    foreach (CONFIG ${CMAKE_CONFIGURATION_TYPES})
        list(APPEND CDB_FILES "${CMAKE_BINARY_DIR}/${CONFIG}_compile_commands.json")
    endforeach ()

    add_custom_command(OUTPUT ${CDB_FILES}
        COMMAND $<TARGET_FILE:CDBSplitter>
        DEPENDS CDBSplitter ${CMAKE_BINARY_DIR}/compile_commands.json
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
        VERBATIM
    )

else ()

    set(CDB_FILE compile_commands.json)

endif ()

add_custom_target(StaticAnalysis
    COMMAND $<TARGET_FILE:RunClangTidy> ${CDB_FILE}
    DEPENDS ${CMAKE_BINARY_DIR}/${CDB_FILE}
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    COMMENT "Running clang-tidy on ${CDB_FILE}"
    VERBATIM
)