newoption {
    trigger = "with-crc",
    description = "Enable vector instructions to use CRC intrinsics"
}

newoption {
    trigger = "with-exceptions",
    description = "Exceptions Always Enabled? (ON/OFF)"
}
EXCEPTIONS_ENABLED = "Off"
if _OPTIONS["with-exceptions"] ~= nil then
    EXCEPTIONS_ENABLED = "On"
end

newoption {
    trigger = "dynamic-runtime",
    description = "Should use dynamically linked runtime?"
}
STATIC_RUNTIME = "On"
if _OPTIONS["dynamic-runtime"] ~= nil then
    STATIC_RUNTIME = "Off"
end

CRC_ENABLED = "Default"
if _OPTIONS["with-crc"] ~= nil then
    CRC_ENABLED = "AVX" -- technically only need sse4.2 but MSVC doesn't have a switch for that
end

SRC_DIR = "src/"
