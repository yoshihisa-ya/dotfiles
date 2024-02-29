local wezterm = require 'wezterm';

return {
  ssh_domains = {
    {
      name = 'linux-work1',
      remote_address = 'linux-work1.yoshihisa.link',
      username = 'yoshihisa',
    },
  },
  font = wezterm.font("HackGen35 Console NF", {weight="Regular", stretch="Normal", style="Normal"}),
  use_ime = true,
  -- disable_default_key_bindings = true,
  leader = { key = 't', mods = 'CTRL', timeout_milliseconds = 1000 },
  keys = {
    -- tmux like keybinds
    { key = '\"', mods = 'LEADER|SHIFT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' }, },
    { key = '%', mods = 'LEADER|SHIFT', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }, },
    { key = 'c', mods = 'LEADER', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
    { key = 'p', mods = 'LEADER', action = wezterm.action.ActivateTabRelative(-1) },
    { key = 'n', mods = 'LEADER', action = wezterm.action.ActivateTabRelative(1) },
    { key = 'z', mods = 'LEADER', action = wezterm.action.TogglePaneZoomState },
    { key = 't', mods = 'LEADER|CTRL', action = wezterm.action.SendString '\x14', },
  },
  font_size = 11,
  use_fancy_tab_bar = false,
  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  tab_bar_at_bottom = true,
  tab_max_width = 16,
  adjust_window_size_when_changing_font_size = false,
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
  colors = {
    background = '#000000',
    foreground = '#e5e5e5',
    cursor_bg = '#e5e5e5',
    cursor_fg = '#000000',
    cursor_border = '#e5e5e5',
    ansi = {
      '#000000',
      '#cd0000',
      '#00cd00',
      '#cdcd00',
      '#5c5cff',
      '#cd00cd',
      '#00cdcd',
      '#e5e5e5',
    },
    brights = {
      '#7f7f7f',
      '#ff0000',
      '#00ff00',
      '#ffff00',
      '#5c5cff',
      '#ff00ff',
      '#00ffff',
      '#ffffff',
    },
  },
  inactive_pane_hsb = {
    saturation = 0.7,
    brightness = 0.3,
  },
  window_background_image_hsb = {
    brightness = 0.15,
    hue = 1.0,
    saturation = 1.0,
  },
  text_background_opacity = 1.0,
  window_background_opacity = 0.7
}

