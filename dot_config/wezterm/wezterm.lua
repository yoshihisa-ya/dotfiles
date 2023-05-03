local wezterm = require 'wezterm';

return {
  font = wezterm.font("HackGen35 Console NFJ", {weight="Regular", stretch="Normal", style="Normal"}),
  use_ime = true,
  font_size = 11,
  hide_tab_bar_if_only_one_tab = true,
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
  window_background_image = '/home/yoshihisa/Sync/wallpaper/2ec475b3-173e-4ecb-b594-38bc3ca6e36a.jpg',
  window_background_image_hsb = {
    brightness = 0.15,
    hue = 1.0,
    saturation = 1.0,
  },
  text_background_opacity = 1.0,
}

