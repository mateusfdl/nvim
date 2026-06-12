local M = {}

function M.curl_args(config, body)
  local key = vim.env[config.api_key_env]
  if key == nil or key == "" then
    error(string.format("tdw: $%s is not set", config.api_key_env), 0)
  end
  local payload = vim.tbl_extend("force", { model = config.model }, body)
  return {
    "curl",
    "-sS",
    "--fail-with-body",
    config.base_url .. "/chat/completions",
    "-H",
    "Authorization: Bearer " .. key,
    "-H",
    "Content-Type: application/json",
    "-d",
    vim.json.encode(payload),
  }
end

function M.extract(raw)
  local ok, response = pcall(vim.json.decode, raw)
  if not ok or type(response) ~= "table" then
    error("tdw: invalid api response: body is not json", 0)
  end
  if response.error ~= nil then
    local message = type(response.error) == "table" and response.error.message or tostring(response.error)
    error(string.format("tdw: api error: %s", message), 0)
  end
  local choice = type(response.choices) == "table" and response.choices[1] or nil
  local content = choice and choice.message and choice.message.content
  if type(content) ~= "string" then
    error("tdw: invalid api response: missing message content", 0)
  end
  local decoded_ok, payload = pcall(vim.json.decode, content)
  if not decoded_ok or type(payload) ~= "table" then
    error("tdw: invalid api response: message content is not json", 0)
  end
  return payload
end

function M.complete(config, body, on_result)
  local args = M.curl_args(config, body)
  vim.system(args, { text = true }, function(out)
    vim.schedule(function()
      if out.code ~= 0 then
        local detail = (out.stderr ~= nil and out.stderr ~= "") and out.stderr or out.stdout
        on_result(nil, string.format("tdw: request failed: %s", vim.trim(detail or "")))
        return
      end
      local ok, payload = pcall(M.extract, out.stdout)
      if not ok then
        on_result(nil, payload)
        return
      end
      on_result(payload, nil)
    end)
  end)
end

return M
