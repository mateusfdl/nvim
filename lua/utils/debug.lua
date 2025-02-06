local log_file = "/tmp/nvim_log_" .. tostring(math.random(100000, 999999)) .. ".json"

local function log_to_file(data)
	vim.schedule(function()
		local json = vim.fn.json_encode(data)
		vim.fn.writefile({ json }, log_file, "a")
	end)
end

P = function(v)
	local info = debug.getinfo(2, "Sl")
	local log_entry = {
		value = v,
		source = info.source,
		line = info.currentline,
	}
	print(vim.inspect(v))
	log_to_file(log_entry)
	return v
end

P_nested_path = function(tbl, keys)
	if #keys == 0 then
		return P(tbl)
	end
	local key = keys[1]
	if tbl[key] == nil then
		return nil
	end
	return P_nested_path(tbl[key], { unpack(keys, 2) })
end

return M
