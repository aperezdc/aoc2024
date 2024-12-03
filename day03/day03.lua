#! /usr/bin/env lua
--
-- SPDX-License-Identifier: MIT
--

local mul_re = [[mul%((%d+),(%d+)%)]]

local function calculate_muls(text)
   local result = 0
   for a, b in text:gmatch(mul_re) do
      result = result + tonumber(a) * tonumber(b)
   end
   return result
end

local op_do_str = [[do()]]
local op_dont_str = [[don't()]]

local function calculate_muls_do_dont(text)
   local result = 0
   local curpos = 1
   local textlen = #text
   local extracting = true
   while curpos <= textlen do
      if extracting then
         local b, e = text:find(op_dont_str, curpos, true)
         if b then
            extracting = false
         else
            b = textlen
            e = textlen
         end
         result = result + calculate_muls(text:sub(curpos, b - 1))
         curpos = e + 1
      else
         local b, e = text:find(op_do_str, curpos, true)
         if b then
            extracting = true
         else
            b = textlen
            e = textlen
         end
         curpos = e + 1
      end
   end
   return result
end

local input = io.read("*a")
print("Part 1: ", calculate_muls(input))
print("Part 2: ", calculate_muls_do_dont(input))
