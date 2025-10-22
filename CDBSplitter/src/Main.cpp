#include <rfl/json/load.hpp>
#include <rfl/json/save.hpp>

#include <iostream>
#include <string>
#include <string_view>
#include <unordered_map>
#include <vector>

struct Command
{
    std::string directory;
    std::string command;
    std::string file;
    std::string output;
};

static constexpr std::string_view k_SearchKey = "-DCMAKE_INTDIR=\\\"";

int main()
{
    rfl::Result<std::vector<Command>> result = rfl::json::load<std::vector<Command>>("compile_commands.json");
    if (!result.has_value())
    {
        std::cout << "Loading compile_commands.json failed: " << result.error().what() << '\n';
        return 1;
    }

    std::unordered_map<std::string, std::vector<Command>> configCommands;
    for (const auto& command : result.value())
    {
        size_t offset = command.command.find(k_SearchKey);
        size_t start = offset + k_SearchKey.size();
        size_t end = std::string::npos;
        if (offset != std::string::npos)
            end = command.command.find("\\\" ", start);

        if (end == std::string::npos)
        {
            std::cout << "Unable to detect configuration for command \"" << command.command << "\"\n";
            continue;
        }

        std::string configuration = command.command.substr(start, end - start);
        configCommands[configuration].emplace_back(command);
    }

    for (const auto& [configuration, commands] : configCommands)
        rfl::json::save(configuration + "_compile_commands.json", commands);
}