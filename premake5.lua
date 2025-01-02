local platform_backend = _OPTIONS["platform_backend"]
local gpu_api_backend = _OPTIONS["gpu_api_backend"]

if not platform_backend then
    print("Error: platform_backend is required.")
    os.exit(1)
end

if not gpu_api_backend then
    print("Error: gpu_api_backend is required.")
    os.exit(1)
end

print("Platform Backend: " .. platform_backend)
print("GPU API Backend: " .. gpu_api_backend)

project("ImGui")
kind("StaticLib")
language("C++")
staticruntime("off")
targetdir("bin/%{cfg.buildcfg}")

local files_to_add = {
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
}

if platform_backend == "win32" then
    table.insert(files_to_add, "backends/imgui_impl_win32.h")
    table.insert(files_to_add, "backends/imgui_impl_win32.cpp")
end

if gpu_api_backend == "dx12" then
    table.insert(files_to_add, "backends/imgui_impl_dx12.h")
    table.insert(files_to_add, "backends/imgui_impl_dx12.cpp")
end

includedirs('.')

files(files_to_add)

filter("system:windows")
systemversion("latest")
cppdialect("C++20")

filter("configurations:Debug")
runtime("Debug")
symbols("on")

filter("configurations:Release")
runtime("Release")
optimize("on")
