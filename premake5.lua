local platform_backend = _ARGS["platform_backend"]
local gpu_api_backend = _ARGS["gpu_api_backend"]

project("ImGui")
kind("StaticLib")
language("C++")
staticruntime("off")

targetdir("bin/" .. outputdir .. "/%{prj.name}")
objdir("bin-int/" .. outputdir .. "/%{prj.name}")

files({
    "imconfig.h",
    "imgui.h",
    "imgui.cpp",
    "imgui_draw.cpp",
    "imgui_internal.h",
    "imgui_tables.cpp",
    "imgui_widgets.cpp",
    "imstb_rectpack.h",
    "imstb_textedit.h",
    "imstb_truetype.h",
    "imgui_demo.cpp",
})

if platform_backend == "win32" then
    table.insert(files, "backend/imgui_impl_win32.h")
    table.insert(files, "backend/imgui_impl_win32.cpp")
end

if gpu_api_backend == "dx12" then
    table.insert(files, "backend/imgui_impl_dx12.h")
    table.insert(files, "backend/imgui_impl_dx12.cpp")
end

filter("system:windows")
systemversion("latest")
cppdialect("C++20")

filter("configurations:Debug")
runtime("Debug")
symbols("on")

filter("configurations:Release")
runtime("Release")
optimize("on")
