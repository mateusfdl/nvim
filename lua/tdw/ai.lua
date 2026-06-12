local M = {}

local candidates_schema = {
  type = "object",
  properties = {
    candidates = {
      type = "array",
      items = {
        type = "object",
        properties = {
          input = { type = "string" },
          reason = { type = "string" },
        },
        required = { "input", "reason" },
        additionalProperties = false,
      },
    },
  },
  required = { "candidates" },
  additionalProperties = false,
}

local trace_schema = {
  type = "object",
  properties = {
    trace = {
      type = "array",
      items = {
        type = "object",
        properties = {
          line = { type = "integer" },
          hint = { type = "string" },
        },
        required = { "line", "hint" },
        additionalProperties = false,
      },
    },
  },
  required = { "trace" },
  additionalProperties = false,
}

local candidates_system = table.concat({
  "You analyze the control flow of a single function.",
  "Propose the smallest set of input values that together exercise every distinct branch of the function.",
  "Each candidate is the literal source representation of the call argument(s), e.g. 5 or \"abc\" or {a: 1}.",
  "Each reason names the branch that input exercises, in a few words.",
}, " ")

local trace_system = table.concat({
  "You simulate the execution of a single function for one concrete input.",
  "Walk the execution path that input takes.",
  "For every executed line where data changes or a result is produced, emit one trace entry:",
  "the value of the expression or variable after that line runs, e.g. 5 or [\"hallo\", 4] or return \"bar\".",
  "Skip lines the execution never reaches and lines where nothing observable happens.",
  "line is the 0-based offset from the first line of the function source.",
  "Line 0 is always included with the input value as its hint.",
}, " ")

local function user_content(fn_text, lang)
  return string.format("Language: %s\n\n```%s\n%s\n```", lang, lang, fn_text)
end

function M.candidates_request(fn_text, lang)
  return {
    messages = {
      { role = "system", content = candidates_system },
      { role = "user", content = user_content(fn_text, lang) },
    },
    response_format = {
      type = "json_schema",
      json_schema = { name = "candidates", strict = true, schema = candidates_schema },
    },
  }
end

function M.trace_request(fn_text, lang, input)
  return {
    messages = {
      { role = "system", content = trace_system },
      {
        role = "user",
        content = user_content(fn_text, lang) .. string.format('\n\nInput: "%s"', input),
      },
    },
    response_format = {
      type = "json_schema",
      json_schema = { name = "trace", strict = true, schema = trace_schema },
    },
  }
end

local function invalid(detail)
  error(string.format("tdw: invalid AI response: %s", detail), 0)
end

function M.parse_candidates(payload)
  if type(payload) ~= "table" or type(payload.candidates) ~= "table" then
    invalid("missing candidates list")
  end
  if #payload.candidates == 0 then invalid("empty candidates list") end
  local candidates = {}
  for i, candidate in ipairs(payload.candidates) do
    if type(candidate) ~= "table" or type(candidate.input) ~= "string" or type(candidate.reason) ~= "string" then
      invalid(string.format("malformed candidate at index %d", i))
    end
    candidates[i] = { input = candidate.input, reason = candidate.reason }
  end
  return candidates
end

function M.parse_trace(payload)
  if type(payload) ~= "table" or type(payload.trace) ~= "table" then
    invalid("missing trace list")
  end
  if #payload.trace == 0 then invalid("empty trace list") end
  local trace = {}
  for i, entry in ipairs(payload.trace) do
    if type(entry) ~= "table" or type(entry.line) ~= "number" or type(entry.hint) ~= "string" then
      invalid(string.format("malformed trace entry at index %d", i))
    end
    trace[i] = { line = entry.line, hint = entry.hint }
  end
  return trace
end

return M
