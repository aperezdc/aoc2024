#! /usr/bin/env lua
--
-- SPDX-License-Identifier: MIT
--

local rule_re = [[^(%d+)|(%d+)$]]

local rules = {}

local function addrule(prev, next)
	local t = rules[prev]
	if not t then
		t = {}
		rules[prev] = t
	end
	t[#t + 1] = next
end

for line in io.lines() do
	if #line == 0 then
		break
	end
	local prev, next = line:match(rule_re)
	addrule(tonumber(prev), tonumber(next))
end

local function valid_order(pages)
	local seen = {}
	for _, num in ipairs(pages) do
		local numsAfter = rules[num] or {}
		for _, numAfter in ipairs(numsAfter) do
			if seen[numAfter] then
				return false
			end
		end
		seen[num] = true
	end
	return true
end

local result = 0
for line in io.lines() do
	local pages = {}
	for num in line:gmatch("(%d+),?") do
		pages[#pages + 1] = tonumber(num)
	end
	if valid_order(pages) then
		-- Add middle point page number
		result = result + pages[#pages // 2 + 1]
	end
end
print(result)
