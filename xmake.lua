add_rules("mode.debug", "mode.release")

set_config("buildir", "Build")

add_requires("glfw","spdlog","vulkansdk","glfw","tinygltf","imgui","glm","nlohmann_json")

target("MyToyRenderer")
    set_kind("binary") 
    set_languages("c++23")
    add_cxxflags("/std:c++latest")
    add_cxxflags("/utf-8")
    set_policy("build.c++.modules", true)

    add_files("Renderer/Source/*.cpp")
    add_files("Renderer/Source/*.ixx")
    add_headerfiles("Renderer/Source/*.hpp")
    add_includedirs("Renderer/ThirdParty/")
    add_packages("spdlog","vulkansdk","glfw","tinygltf","imgui","glm","nlohmann_json")
    add_includedirs("Renderer/ThirdParty/KTX/inlcude","Renderer/ThirdParty/KTX/other_inlcude")
    set_runenv("PROJECT_PATH", os.projectdir())




