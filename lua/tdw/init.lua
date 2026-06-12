local ai = require("tdw.ai")
local fn = require("tdw.fn")
local hints = require("tdw.hints")

local M = {}

local defaults = {
  model = "anthropic/claude-sonnet-4.5",
  base_url = "https://openrouter.ai/api/v1",
  api_key_env = "OPENROUTER_API_KEY",
}

local config = vim.deepcopy(defaults)
local client = nil

local function active_client()
  return client or require("tdw.client")
end

local function notify_error(msg)
  vim.notify(msg, vim.log.levels.ERROR)
end

local subcommands = { "analyze", "clear" }

local function register_command()
  vim.api.nvim_create_user_command("Tdw", function(cmd)
    local subcommand = cmd.args ~= "" and cmd.args or "analyze"
    if not vim.tbl_contains(subcommands, subcommand) then
      return notify_error(string.format("tdw: unknown subcommand %q", subcommand))
    end
    local ok, err = pcall(M[subcommand])
    if not ok then notify_error(err) end
  end, {
    nargs = "?",
    complete = function()
      return subcommands
    end,
  })
end

function M.setup(opts)
  opts = opts or {}
  client = opts.client
  config = {
    model = opts.model or defaults.model,
    base_url = opts.base_url or defaults.base_url,
    api_key_env = opts.api_key_env or defaults.api_key_env,
  }
  register_command()
end

local function request_trace(bufnr, tick, target, input)
  active_client().complete(config, ai.trace_request(target.text, target.lang, input), function(payload, err)
    if err ~= nil then return notify_error(err) end
    local ok, trace = pcall(ai.parse_trace, payload)
    if not ok then return notify_error(trace) end
    if vim.b[bufnr].changedtick ~= tick then
      return notify_error("tdw: buffer changed during analysis")
    end
    hints.render(bufnr, target.start_row, trace)
  end)
end

local function pick_candidate(bufnr, tick, target, candidates)
  vim.ui.select(candidates, {
    prompt = "tdw: pick an input",
    format_item = function(candidate)
      return string.format("%s  (%s)", candidate.input, candidate.reason)
    end,
  }, function(choice)
    if choice == nil then return end
    if vim.b[bufnr].changedtick ~= tick then
      return notify_error("tdw: buffer changed during analysis")
    end
    request_trace(bufnr, tick, target, choice.input)
  end)
end

function M.analyze()
  local bufnr = vim.api.nvim_get_current_buf()
  local target = fn.under_cursor(bufnr)
  local tick = vim.b[bufnr].changedtick
  hints.clear(bufnr)
  active_client().complete(config, ai.candidates_request(target.text, target.lang), function(payload, err)
    if err ~= nil then return notify_error(err) end
    local ok, candidates = pcall(ai.parse_candidates, payload)
    if not ok then return notify_error(candidates) end
    pick_candidate(bufnr, tick, target, candidates)
  end)
end

function M.clear()
  hints.clear(vim.api.nvim_get_current_buf())
end

return M
