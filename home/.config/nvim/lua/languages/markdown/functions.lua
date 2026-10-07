-- Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

-- Helpers to find the fenced code block (or lines) to run. Pure functions on
-- a list of lines (no buffer, no UI), so they can be tested headless.

local M = {}

-- Fence opener as { indent (width), fence (run of 3+ backticks or tildes),
-- info (the info string) }, or nil if `line` doesn't open a fence.
local function parse_open(line)
	local indent, fence, info = line:match("^(%s*)(```+)(.*)$")
	if not fence then
		indent, fence, info = line:match("^(%s*)(~~~+)(.*)$")
	end
	if not fence then
		return nil
	end
	-- A backtick fence can't have backticks in its info string: that's
	-- inline code (```like this```) on a single line, not a fence.
	if fence:sub(1, 1) == "`" and info:find("`", 1, true) then
		return nil
	end
	return { indent = #indent, fence = fence, info = info }
end

local function is_close(line, fence)
	local run = line:match("^%s*(" .. fence:sub(1, 1) .. "+)%s*$")
	return run ~= nil and #run >= #fence
end

local function dedent(line, width)
	return line:sub(math.min(#line:match("^%s*"), width) + 1)
end

-- Fenced blocks of `lines` as { lang, open, close, first, last, indent }:
-- 1-based line numbers, `first`..`last` being the content (`last < first`
-- for an empty block). An unclosed fence runs to the end of the buffer.
function M.parse(lines)
	local blocks, current = {}, nil
	for i, line in ipairs(lines) do
		if not current then
			local opener = parse_open(line)
			if opener then
				local lang = opener.info:match("^%s*{?%.?([%w_+#-]+)")
				current = {
					lang = lang and lang:lower(),
					open = i,
					first = i + 1,
					indent = opener.indent,
					fence = opener.fence,
				}
			end
		elseif is_close(line, current.fence) then
			current.close, current.last = i, i - 1
			table.insert(blocks, current)
			current = nil
		end
	end
	if current then
		current.close, current.last = #lines, #lines
		table.insert(blocks, current)
	end
	return blocks
end

-- What to run, as `code_lines, lang` (`lang` is nil for an untagged block) or
-- `nil, error_message`.
-- Without `range`: the block under the cursor line `cursor`. With
-- `range = { first, last }`: those lines, clamped to the first block they
-- touch (so a selection that includes the fences, or runs past them, still
-- yields only code).
function M.pick(lines, cursor, range)
	local from, to = cursor, cursor
	if range then
		from, to = range[1], range[2]
	end

	local block
	for _, b in ipairs(M.parse(lines)) do
		if b.open <= to and b.close >= from then
			block = b
			break
		end
	end
	if not block then
		return nil, "not in a fenced code block"
	end

	if range then
		from, to = math.max(from, block.first), math.min(to, block.last)
	else
		from, to = block.first, block.last
	end

	local code = {}
	for i = from, to do
		table.insert(code, dedent(lines[i], block.indent))
	end
	if vim.trim(table.concat(code)) == "" then
		return nil, "nothing to run"
	end
	return code, block.lang
end

return M
