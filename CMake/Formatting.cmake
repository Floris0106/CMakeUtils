if (UTILS_ENABLE_FORMATTING)

    find_program(CLANG_FORMAT_BIN clang-format)

    if (NOT CLANG_FORMAT_BIN)

        message(WARNING "clang-format not found, formatting checks are disabled")
        set(UTILS_ENABLE_FORMATTING OFF)

    endif ()

endif ()

if (NOT UTILS_ENABLE_FORMATTING)

    function(target_check_formatting TARGET)
    endfunction()

    return()

endif()

add_custom_target(All-CheckFormatting)
add_custom_target(All-FixFormatting)

function(target_check_formatting TARGET)
    get_target_sources(${TARGET} FILES)

    add_custom_target(${TARGET}-CheckFormatting
        COMMAND ${CLANG_FORMAT_BIN} --dry-run --Werror  ${FILES}
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        COMMENT "Checking code formatting for target ${TARGET}"
        VERBATIM
    )
    add_dependencies(All-CheckFormatting ${TARGET}-CheckFormatting)

    add_custom_target(${TARGET}-FixFormatting
        COMMAND ${CLANG_FORMAT_BIN} -i ${FILES}
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        COMMENT "Automatically fixing code formatting for target ${TARGET}"
        VERBATIM
    )
    add_dependencies(All-FixFormatting ${TARGET}-FixFormatting)
endfunction()