#include <rfl/json/load.hpp>

#include <cstdlib>
#include <iostream>
#include <sstream>
#include <string>

struct Command
{
    std::string directory;
    std::string command;
    std::string file;
    std::string output;
};

int main(int argc, char** argv)
{
    if (argc != 2)
    {
        std::cout << "Usage: " << argv[0] << " path/to/compile_commands.json\n";
        return 1;
    }

    rfl::Result<std::vector<Command>> result = rfl::json::load<std::vector<Command>>(argv[1]);
    if (!result.has_value())
    {
        std::cout << "Loading compilation database failed: " << result.error().what() << '\n';
        return 1;
    }

    std::ostringstream runCommand;
    runCommand << "clang-tidy -p " << argv[1] << " --quiet";

    for (const auto& command : result.value())
        runCommand << " \"" << command.file << '\"';

    std::system(runCommand.str().c_str());
}