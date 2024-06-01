local wezterm = require 'wezterm'

local function get_os()
  -- Attempt to identify the OS with an environment variable or similar method.
  local os_name = package.config:sub(1, 1) == '/' and io.popen('uname'):read '*l' or nil

  if os_name == 'Linux' then
    return 'Linux'
  elseif os_name == 'Darwin' then
    return 'Mac'
  else
    return 'Unknown'
  end
end

local current_os = get_os()
local font_size

if current_os == 'Linux' then
  font_size = 16
elseif current_os == 'Mac' then
  font_size = 21
  wezterm.on('window-resized', function(_, _)
    -- Relaod configuration to force redrawing to prevent
    -- ugly blur effect
    wezterm.reload_configuration()
  end)
end

-- Color scheme (Kanagwa)
local colors = {
  foreground = '#dcd7ba',
  background = '#1f1f28',

  cursor_bg = '#c8c093',
  cursor_fg = '#c8c093',
  cursor_border = '#c8c093',

  selection_fg = '#c8c093',
  selection_bg = '#2d4f67',

  scrollbar_thumb = '#16161d',
  split = '#16161d',

  ansi = { '#090618', '#c34043', '#76946a', '#c0a36e', '#7e9cd8', '#957fb8', '#6a9589', '#c8c093' },
  brights = { '#727169', '#e82424', '#98bb6c', '#e6c384', '#7fb4ca', '#938aa9', '#7aa89f', '#dcd7ba' },
  indexed = { [16] = '#ffa066', [17] = '#ff5d62' },
}

return {
  colors = colors,
  font = wezterm.font_with_fallback {
    {
      family = 'JetBrainsMono Nerd Font',
      harfbuzz_features = {
        'zero', -- Zero
        'cv14', -- Dollar sign
        'cv18', -- 269
        'cv19', -- 8
      },
    },
  },
  font_size = font_size,
  cell_width = 0.9,
  line_height = 1.1,
  window_background_opacity = 0.90,
  macos_window_background_blur = 25,
  window_background_gradient = {
    orientation = 'Vertical',
    colors = {
      '#1F1F28',
      '#1F1F28',
      '#050506',
    },
  },
  enable_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,
  force_reverse_video_cursor = true,
  window_decorations = 'RESIZE',
  adjust_window_size_when_changing_font_size = false,
  window_padding = {
    left = 10,
    right = 5,
    top = 0,
    bottom = 5,
  },
  use_dead_keys = false,
  scrollback_lines = 5000,
  animation_fps = 75,
  automatically_reload_config = true,
  audible_bell = 'Disabled',
  window_close_confirmation = 'NeverPrompt',
}
