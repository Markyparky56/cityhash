local SRC_DIR = "src/"

-- Append solution type to build dir
local BUILD_DIR = path.join("build/", _ACTION)
-- If specific compiler specified, append that too
if _OPTIONS["cc"] ~= nil then
    BUILD_DIR = BUILD_DIR .. "_" .. _OPTIONS["cc"]
end

newoption {
    trigger = "with-crc",
    description = "Enable vector instructions to use CRC intrinsics"
}
local CRC_ENABLED = "Default"
if _OPTIONS["with-crc"] ~= nil then
    CRC_ENABLED = "AVX" -- technically only need sse4.2 but MSVC doesn't have a switch for that
end

workspace "cityhash"
    location (BUILD_DIR)
    startproject "cityhash-test"
    configurations { 
        "Debug", 
        "Release" 
        -- Further configs go here (e.g. Testing, Shipping)
    }
    -- Let 32 bit die already
    if os.is64bit() then
        platforms "x86_64"
    else
        platforms "x86"
    end
    targetdir (BUILD_DIR .. "/bin/" .. "%{cfg.architecture}" .. "/" .. "%{cfg.shortname}")
    debugdir "%{cfg.targetdir}"
    objdir (BUILD_DIR .. "/bin/obj/" .. "%{cfg.architecture}" .. "/" .. "%{cfg.shortname}")

    filter "configurations:Debug"
        defines 
        {
            "_DEBUG"
        }
        optimize "Debug"
        symbols "On"
    filter "configurations:Release"
        defines
        {
            "NDEBUG"
        }
        optimize "Full"
    filter "platforms:x86"
        architecture "x86"
    filter "platforms:x86_64"
        architecture "x86_64"
    filter "action:vs*"
        buildoptions { "/Zc:__cplusplus" }
        flags { "MultiProcessorCompile" }
    filter "files:**.cc"
        compileas "C"


project "cityhash-c"
    kind "StaticLib"
    language "C"
    vectorextensions (CRC_ENABLED)
    files
    {
        path.join(SRC_DIR, "city.h"),
        path.join(SRC_DIR, "citycrc.h"),
        path.join(SRC_DIR, "city.cc"),
    }
    includedirs
    {
        (SRC_DIR)
    }

project "cityhash-test"
    kind "ConsoleApp"
    language "C"
    vectorextensions (CRC_ENABLED)
    files
    {
        path.join(SRC_DIR, "city.h"),
        path.join(SRC_DIR, "citycrc.h"),
        path.join(SRC_DIR, "city.cc"),
        path.join(SRC_DIR, "city-test.cc")
    }
    includedirs
    {
        (SRC_DIR)
    }
