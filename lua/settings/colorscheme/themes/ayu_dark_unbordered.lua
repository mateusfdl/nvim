-- credits to original theme https://github.com/ayu-theme/vscode-ayu (ayu-dark-unbordered)
-- Borderless variant of ayu_dark: identical syntax, flat #0d1017 chrome with no split borders.

local M = {}

M.base_30 = {
  white = "#ced4df",
  darker_black = "#0a0e15",
  black = "#0d1017", --  nvim bg
  black2 = "#141821",
  one_bg = "#161a24",
  one_bg2 = "#1d212b",
  one_bg3 = "#242833",
  grey = "#33363c",
  grey_fg = "#3d4046",
  grey_fg2 = "#46494f",
  light_grey = "#54575d",
  red = "#F07178",
  baby_pink = "#ff949b",
  pink = "#ff8087",
  line = "#0d1017", -- flattened to bg: no vertsplit border
  green = "#AAD94C",
  vibrant_green = "#b9e75b",
  blue = "#39BAE6",
  nord_blue = "#59C2FF",
  yellow = "#FFB454",
  sun = "#f0df8a",
  purple = "#D2A6FF",
  dark_purple = "#A37ACC",
  teal = "#74c5aa",
  orange = "#FF8F40",
  cyan = "#95E6CB",
  statusline_bg = "#0d1017",
  lightbg = "#1d212b",
  pmenu_bg = "#ff9445",
  folder_bg = "#98a3af",
}

M.base_16 = {
  base00 = "#0d1017",
  base01 = "#161a24",
  base02 = "#1d212b",
  base03 = "#242833",
  base04 = "#33363c",
  base05 = "#BFBDB6",
  base06 = "#E6E1CF",
  base07 = "#D9D7CE",
  base08 = "#F07178",
  base09 = "#D2A6FF",
  base0A = "#59C2FF",
  base0B = "#AAD94C",
  base0C = "#95E6CB",
  base0D = "#FFB454",
  base0E = "#FF8F40",
  base0F = "#E6B673",
}

local entity = M.base_30.nord_blue
local tag = M.base_30.blue
local constant = M.base_30.purple
local func = M.base_16.base0D
local member = M.base_30.red
local operator = "#F29668"
local decorator = "#E6C08A"
local punctuation = M.base_16.base05

M.polish_hl = {
  WinSeparator = { fg = M.base_30.black },

  Operator = { fg = operator },

  ["@operator"] = { fg = operator },
  ["@constructor"] = { fg = entity },
  ["@namespace"] = { fg = entity },
  ["@type.builtin"] = { fg = tag },
  ["@tag"] = { fg = tag },
  ["@tag.delimiter"] = { fg = tag },
  ["@tag.attribute"] = { fg = func },
  ["@parameter"] = { fg = constant },
  ["@constant"] = { fg = constant },
  ["@constant.builtin"] = { fg = constant },
  ["@constant.macro"] = { fg = decorator },
  ["@function.macro"] = { fg = decorator },
  ["@attribute"] = { fg = decorator },
  ["@annotation"] = { fg = decorator },
  ["@variable.builtin"] = { fg = tag, italic = true },
  ["@field"] = { fg = member },
  ["@field.key"] = { fg = member },
  ["@property"] = { fg = member },
  ["@punctuation.bracket"] = { fg = punctuation },
  ["@punctuation.delimiter"] = { fg = punctuation },
  ["@text.uri"] = { fg = tag, underline = true },
}

M.add_hl = {
  ["@variable.parameter"] = { fg = constant },
  ["@variable.parameter.builtin"] = { fg = constant },
  ["@variable.member"] = { fg = member },
  ["@module"] = { fg = entity },
  ["@module.builtin"] = { fg = entity },
  ["@function.method.call"] = { fg = func },
  ["@markup.link.url"] = { fg = tag, underline = true },
  ["@markup.link.label"] = { fg = func },
}

M.type = "dark"

return M
