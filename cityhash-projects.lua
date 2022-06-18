newoption {
    trigger = "with-crc",
    description = "Enable vector instructions to use CRC intrinsics"
}

local CRC_ENABLED = "Default"
if _OPTIONS["with-crc"] ~= nil then
    CRC_ENABLED = "AVX" -- technically only need sse4.2 but MSVC doesn't have a switch for that
end

local SRC_DIR = "src/"

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
    filter "files:**.cc"
        compileas "C"

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
    filter "files:**.cc"
        compileas "C"