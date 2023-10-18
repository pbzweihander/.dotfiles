local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = 'Snazzy'

config.font = wezterm.font_with_fallback {
  'Victor Mono',
  'Noto Sans CJK KR',
}
config.font_size = 13.0

config.keys = {
  {
    key = 'Enter',
    mods = 'ALT',
    action = wezterm.action.DisableDefaultAssignment,
  },
}

return config
