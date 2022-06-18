include "cityhash-common.lua"

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
