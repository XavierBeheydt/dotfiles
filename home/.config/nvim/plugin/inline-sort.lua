-- Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

-- :InlineSort[!] — sort comma-separated items in place, keeping the layout
-- (spacing, line breaks, trailing comma). ! sorts in reverse.
--   no range  the innermost (), [] or {} around the cursor, else the line
--   :'<,'>    the selection (charwise: exactly the selected text)
-- NOTE: plain comma split, brackets/commas inside strings are not parsed;
-- select the flat part of the list when that matters.

local openers = { ["("] = true, ["["] = true, ["{"] = true }
local closers = { [")"] = true, ["]"] = true, ["}"] = true }

-- 1-based inclusive bounds of the text inside the innermost bracket pair
-- enclosing index `cur` of `line`, or nil when there is none.
local function inner_brackets(line, cur)
	local depth = 0
	for i = cur, 1, -1 do
		local c = line:sub(i, i)
		if closers[c] and i ~= cur then
			depth = depth + 1
		elseif openers[c] then
			if depth == 0 then
				local d = 0
				for j = i + 1, #line do
					local cj = line:sub(j, j)
					if openers[cj] then
						d = d + 1
					elseif closers[cj] then
						if d == 0 then
							return i + 1, j - 1
						end
						d = d - 1
					end
				end
				return nil
			end
			depth = depth - 1
		end
	end
end

-- 0-based (srow, scol, erow, ecol) of the text to sort, end exclusive.
local function target(opts)
	if opts.range == 0 then
		local row, col = unpack(vim.api.nvim_win_get_cursor(0))
		local line = vim.api.nvim_get_current_line()
		local s, e = inner_brackets(line, col + 1)
		if not s then
			s, e = 1, #line
		end
		return row - 1, s - 1, row - 1, e
	end

	local vs = vim.api.nvim_buf_get_mark(0, "<")
	local ve = vim.api.nvim_buf_get_mark(0, ">")
	local last = vim.api.nvim_buf_get_lines(0, opts.line2 - 1, opts.line2, true)[1]
	if vim.fn.visualmode() == "v" and vs[1] == opts.line1 and ve[1] == opts.line2 and #last > 0 then
		-- '> points at the start of the last selected char (or past eol with $)
		local ecol = math.min(ve[2], #last - 1) + 1
		return vs[1] - 1, vs[2], ve[1] - 1, ecol + vim.str_utf_end(last, ecol)
	end
	return opts.line1 - 1, 0, opts.line2 - 1, #last
end

local function sort_items(text, reverse)
	local slots, items = {}, {}
	for seg in (text .. ","):gmatch("([^,]*),") do
		local lead, item, trail = seg:match("^(%s*)(.-)(%s*)$")
		slots[#slots + 1] = { lead, item, trail }
		if item ~= "" then
			items[#items + 1] = item
		end
	end
	table.sort(items, function(a, b)
		if reverse then
			return a > b
		end
		return a < b
	end)

	local out, i = {}, 0
	for _, slot in ipairs(slots) do
		if slot[2] ~= "" then
			i = i + 1
			slot[2] = items[i]
		end
		out[#out + 1] = table.concat(slot)
	end
	return table.concat(out, ",")
end

vim.api.nvim_create_user_command("InlineSort", function(opts)
	local srow, scol, erow, ecol = target(opts)
	local text = table.concat(vim.api.nvim_buf_get_text(0, srow, scol, erow, ecol, {}), "\n")
	local sorted = sort_items(text, opts.bang)
	if sorted ~= text then
		vim.api.nvim_buf_set_text(0, srow, scol, erow, ecol, vim.split(sorted, "\n", { plain = true }))
	end
end, { range = true, bang = true, desc = "Sort comma-separated items in place" })
