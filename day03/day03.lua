#! /usr/bin/env lua
--
-- SPDX-License-Identifier: MIT
--

local mul_re = [[mul%((%d+),(%d+)%)]]
local result = 0
local input = io.read("*a")
for a, b in input:gmatch(mul_re) do
   result = result + tonumber(a) * tonumber(b)
end
print(result)
