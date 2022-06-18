include "cityhash-common.lua"

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
