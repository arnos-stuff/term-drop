-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane
  -- in that tab
  return tab_info.active_pane.title
end

config.use_fancy_tab_bar = false
config.show_tabs_in_tab_bar = true
config.show_new_tab_button_in_tab_bar = true

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local title = tab_title(tab)
    if tab.is_active then
      return {
          { Background = { Color = '#9e0dff' } },
          { Foreground = { Color = '#e409e8' } }
        }
    end
    return title
  end
)

-- For example, changing the color scheme:
config.color_scheme = 'BlueBerry Pie'
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.8
config.font = wezterm.font_with_fallback {
  {
    family = 'JetBrains Mono',
    weight = 'Light',
    harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' },
  },
  { family = 'Fira Code', weight = Light },
  'Iosevka Aile',
}
config.window_background_gradient = {
  -- Can be "Vertical" or "Horizontal".  Specifies the direction
  -- in which the color gradient varies.  The default is "Horizontal",
  -- with the gradient going from left-to-right.
  -- Linear and Radial gradients are also supported; see the other
  -- examples below
  orientation = {
      Radial = {
        -- Specifies the x coordinate of the center of the circle,
        -- in the range 0.0 through 1.0.  The default is 0.5 which
        -- is centered in the X dimension.
        cx = 0.75,
  
        -- Specifies the y coordinate of the center of the circle,
        -- in the range 0.0 through 1.0.  The default is 0.5 which
        -- is centered in the Y dimension.
        cy = 0.75,
  
        -- Specifies the radius of the notional circle.
        -- The default is 0.5, which combined with the default cx
        -- and cy values places the circle in the center of the
        -- window, with the edges touching the window edges.
        -- Values larger than 1 are possible.
        radius = 1.25,
      },
    },

  -- Specifies the set of colors that are interpolated in the gradient.
  -- Accepts CSS style color specs, from named colors, through rgb
  -- strings and more
  colors = {
    '#8800d6',
    '#57358f',
    '#3d0696',
    '#8c0d64',
  },

  -- Instead of specifying `colors`, you can use one of a number of
  -- predefined, preset gradients.
  -- A list of presets is shown in a section below.
  -- preset = "Warm",

  -- Specifies the interpolation style to be used.
  -- "Linear", "Basis" and "CatmullRom" as supported.
  -- The default is "Linear".
  interpolation = 'Linear',

  -- How the colors are blended in the gradient.
  -- "Rgb", "LinearRgb", "Hsv" and "Oklab" are supported.
  -- The default is "Rgb".
  blend = 'Rgb',

  -- To avoid vertical color banding for horizontal gradients, the
  -- gradient position is randomly shifted by up to the `noise` value
  -- for each pixel.
  -- Smaller values, or 0, will make bands more prominent.
  -- The default value is 64 which gives decent looking results
  -- on a retina macbook pro display.
  -- noise = 64,

  -- By default, the gradient smoothly transitions between the colors.
  -- You can adjust the sharpness by specifying the segment_size and
  -- segment_smoothness parameters.
  -- segment_size configures how many segments are present.
  -- segment_smoothness is how hard the edge is; 0.0 is a hard edge,
  -- 1.0 is a soft edge.

  -- segment_size = 11,
  -- segment_smoothness = 0.0,
}

local act = wezterm.action

config.keys = {
  { key = 'LeftArrow', mods = 'CTRL|SHIFT|ALT', action = act.MoveTabRelative(-1) },
  { key = 'RightArrow', mods = 'CTRL|SHIFT|ALT', action = act.MoveTabRelative(1) },
  { key = 'RightArrow', mods = 'CTRL', action = wezterm.action{SendString="\x1bb"} },
  { key = 'RightArrow', mods = 'CTRL', action = wezterm.action{SendString="\x1bf"} },
  { key = 'LeftArrow', mods = 'CTRL|SHIFT', action = act.SendKey { key='LeftArrow', mods = 'CTRL|SHIFT' } },
  { key = 'RightArrow', mods = 'CTRL|SHIFT', action = act.SendKey { key='RightArrow', mods = 'CTRL|SHIFT' } }
}
-- and finally, return the configuration to wezterm
return config
