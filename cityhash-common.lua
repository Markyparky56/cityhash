newoption {
    trigger = "with-crc",
    description = "Enable vector instructions to use CRC intrinsics"
}

CRC_ENABLED = "Default"
if _OPTIONS["with-crc"] ~= nil then
    CRC_ENABLED = "AVX" -- technically only need sse4.2 but MSVC doesn't have a switch for that
end

SRC_DIR = "src/"
