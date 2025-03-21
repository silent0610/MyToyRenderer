add_rules("mode.debug", "mode.release")

set_config("buildir", "Build")

add_requires("glfw","spdlog","vulkansdk","glfw","tinygltf","imgui","glm")

target("MyToyRenderer")
    set_kind("binary") 
    set_languages("c++23")
    add_cxflags("/std:c++latest")
    add_cxxflags("/utf-8")
    set_policy("build.c++.modules", true)

    add_files("Renderer/Source/*.cpp")
    add_files("Renderer/Source/*.ixx")
    add_includedirs("Renderer/Source/")
    add_headerfiles("Renderer/Source/*.h")
    add_includedirs("Renderer/ThirdParty/")
    add_packages("spdlog","vulkansdk","glfw","tinygltf","imgui","glm")




