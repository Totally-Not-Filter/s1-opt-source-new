#!/usr/bin/env lua

local common = require "build_tools.lua.common"

-- Build the ROM.
common.build_rom_and_handle_failure("sonic", "s1built", "", "-p=FF -z=0," .. "kosinskiplus" .. ",Size_of_DAC_driver_guess,after", false, "https://github.com/sonicretro/s1disasm")

-- Correct the ROM's header with a proper checksum and end-of-ROM value.
common.fix_header("s1built.bin")

-- A successful build; we can quit now.
common.exit()
