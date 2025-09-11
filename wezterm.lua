local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

wezterm.log_error('Home ' .. wezterm.home_dir)

config.audible_bell = "Disabled"

-- Color Schemes:
-- config.color_scheme = 'Adventure'
-- config.color_scheme = 'Aco'
-- config.color_scheme = '3024 Night'
-- config.color_scheme = 'Atelierhealth (dark) (terminal.sexy)'
-- config.color_scheme = 'darkmatrix'
-- config.color_scheme = 'darkermatrix'
config.color_scheme = 'dracula'
-- config.color_scheme = 'Ef-Tritanopia-Dark'
-- config.color_scheme = 'Elementary (Gogh)'
-- config.color_scheme = 'Framer'
-- config.color_scheme = 'Harper (Gogh)'
-- config.color_scheme = 'Monokai Remastered'
-- config.color_scheme = 'Moonfly (Gogh)'
--- config.color_scheme = 'Pico (base16)'
-- config.color_scheme = 'Pretty and Pastel (terminal.sexy)'

-- Color overrides
config.colors = {
  background = 'black',
  tab_bar = {
    background = '#000000',

    -- The active tab is the one that has focus in the window
    active_tab = {
      bg_color = '#26393d',
      fg_color = '#ffffff', -- bluish
      underline = 'Single',
    },

    -- Inactive tabs are the tabs that do not have focus
    inactive_tab = {
      bg_color = '#000000',
      fg_color = '#555838',
    },
    inactive_tab_hover = {
      bg_color = '#000000',
      fg_color = '#99a235',
      italic = true,
    },

    -- The color of the inactive tab bar edge/divider
    inactive_tab_edge = '#575757',

    -- The new tab button that let you create new tabs
    new_tab = {
      bg_color = '#000000',
      fg_color = '#ff6500',
    },
    new_tab_hover = {
      bg_color = '#000000',
      fg_color = '#ffdb00',
      italic = true,
    },
  },
  visual_bell = '#160001',
}

config.font = wezterm.font 'Hack Nerd Font Mono'

config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true

config.initial_rows = 48
config.initial_cols = 150

config.keys = {

  -- Tab movement
  {key="LeftArrow", mods="CMD", action=wezterm.action{ActivateTabRelative=-1}},
  {key="RightArrow", mods="CMD", action=wezterm.action{ActivateTabRelative=1}},

  -- Window movement
  {key="LeftArrow", mods="CMD|SHIFT", action=wezterm.action{ActivateWindowRelative=-1}},
  {key="RightArrow", mods="CMD|SHIFT", action=wezterm.action{ActivateWindowRelative=1}},


  -- Clears only the scrollback and leaves the viewport intact. (NOTE: lower k)
  {
    key = 'k',
    mods = 'CMD',
    action = act.Multiple {
      -- act.ClearScrollback 'ScrollbackOnly',
      act.ClearScrollback 'ScrollbackAndViewport',
      act.SendKey { key = 'K', mods = 'OPT|SHIFT' },
    },
  },
  { key = 'l', mods = 'CMD', action = act.ShowLauncher },
}

config.visual_bell = {
  fade_in_function = 'EaseIn',
  fade_in_duration_ms = 150,
  fade_out_function = 'EaseOut',
  fade_out_duration_ms = 150,
}

config.window_decorations = "RESIZE"

config.window_frame = {
  font = wezterm.font { family = 'Roboto', weight = 'Bold' },
  font_size = 12.0,
  active_titlebar_bg = '#333333',
  inactive_titlebar_bg = '#333333',
}

config.use_fancy_tab_bar = false


return config
