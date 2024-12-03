#! /usr/bin/env lua
--
-- SPDX-License-Identifier: MIT
--

local mul_re = [[mul%((%d+),(%d+)%)]]
local result = 0
for line in io.lines() do
   for a, b in line:gmatch(mul_re) do
      result = result + tonumber(a) * tonumber(b)
   end
end
print(result)
