-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 11
config.enable_tab_bar = false
config.window_decorations = "TITLE | RESIZE"
config.window_background_opacity = 0.95
config.colors = {
    background = '#151515',
    foreground = '#e1e1e1',
    cursor_bg = '#e1e1e1',
    cursor_fg = '#151515',
    cursor_border = '#e1e1e1',
    selection_bg = '#5e5e5e',
    selection_fg = '#e1e1e1',
    ansi = {'#202020', '#ac4142', '#88afa2', '#f4bf75', '#73c0ff', '#aa759f', '#5f9ea0', '#d0d0d0', },
    brights = {'#555555', '#cd5c5c', '#90a959', '#ffdead', '#a5d6ff', '#cf75bc', '#75b5aa', '#e1e1e1', },
}

config.window_padding = {
    left = 10,
    right = 10,
    top = 10,
    bottom = 10,
}

-- and finally, return the configuration to wezterm
return config
