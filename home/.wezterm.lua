local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = 'Snazzy'

config.font = wezterm.font_with_fallback {
  'Victor Mono',
  'Noto Sans CJK KR',
  'VictorMono Nerd Font',
}
config.font_size = 13.0

config.hide_tab_bar_if_only_one_tab = true

config.keys = {
  {
    key = 'Enter',
    mods = 'ALT',
    action = wezterm.action.DisableDefaultAssignment,
  },
}

config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'NONE',
    action = wezterm.action.DisableDefaultAssignment,
  },
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CTRL|ALT',
    action = wezterm.action.OpenLinkAtMouseCursor,
  },
}

return config
