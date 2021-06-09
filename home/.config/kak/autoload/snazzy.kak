# snazzy theme

declare-option -hidden str snazzy_white   'rgb:eff0eb'
declare-option -hidden str snazzy_black   'rgb:282a36'
declare-option -hidden str snazzy_red     'rgb:ff5c57'
declare-option -hidden str snazzy_green   'rgb:5af78e'
declare-option -hidden str snazzy_yellow  'rgb:f3f99d'
declare-option -hidden str snazzy_blue    'rgb:57c7ff'
declare-option -hidden str snazzy_magenta 'rgb:ff6ac1'
declare-option -hidden str snazzy_cyan    'rgb:9aedfe'

declare-option -hidden str snazzy_ui_0    'rgb:f9f9f9'
declare-option -hidden str snazzy_ui_1    'rgb:f9f9ff'
declare-option -hidden str snazzy_ui_2    'rgb:eff0eb'
declare-option -hidden str snazzy_ui_3    'rgb:e2e4e5'
declare-option -hidden str snazzy_ui_4    'rgb:a1a6a8'
declare-option -hidden str snazzy_ui_5    'rgb:848688'
declare-option -hidden str snazzy_ui_6    'rgb:5e6c70'
declare-option -hidden str snazzy_ui_7    'rgb:536991'
declare-option -hidden str snazzy_ui_8    'rgb:606580'
declare-option -hidden str snazzy_ui_9    'rgb:3a3d4d'
declare-option -hidden str snazzy_ui_11   'rgb:282a36'
declare-option -hidden str snazzy_ui_12   'rgb:192224'

declare-option -hidden str snazzy_cursor_bg 'rgb:97979b'

declare-option -hidden str snazzy_line_base0  'rgb:858db5'
declare-option -hidden str snazzy_line_base01 'rgb:44485b'
declare-option -hidden str snazzy_line_base1 'rgb:949ecc'
declare-option -hidden str snazzy_line_base2 'rgb:a8b4ea'
declare-option -hidden str snazzy_line_base3 'rgb:f1f1f0'

# kakoune UI
set-face global Default            "%opt{snazzy_white},%opt{snazzy_black}"
set-face global PrimarySelection   "%opt{snazzy_ui_12},%opt{snazzy_ui_1}"
set-face global SecondarySelection "%opt{snazzy_ui_8},%opt{snazzy_ui_1}"
set-face global PrimaryCursor      "%opt{snazzy_ui_12},%opt{snazzy_cursor_bg}"
set-face global SecondaryCursor    "%opt{snazzy_ui_8},%opt{snazzy_cursor_bg}"
set-face global MatchingChar       "%opt{snazzy_yellow},%opt{snazzy_ui_4}"
set-face global Search             "%opt{snazzy_black},%opt{snazzy_yellow}+f"
set-face global Whitespace         "default,%opt{snazzy_red}"
set-face global LineNumbers        "%opt{snazzy_ui_8},default"
set-face global LineNumberCursor   "%opt{snazzy_yellow},default"
set-face global MenuForeground     "%opt{snazzy_green},%opt{snazzy_ui_9}"
set-face global MenuBackground     "default,%opt{snazzy_ui_9}"
set-face global MenuInfo           default,default
set-face global Information        "default,%opt{snazzy_ui_9}"
set-face global Error              "%opt{snazzy_red},default"
set-face global StatusLine         "%opt{snazzy_white},%opt{snazzy_ui_9}"
set-face global StatusLineInfo     "%opt{snazzy_line_base0},%opt{snazzy_ui_9}"
set-face global StatusLineValue    "%opt{snazzy_line_base0},%opt{snazzy_ui_9}"
set-face global StatusLineMode     "%opt{snazzy_ui_9},%opt{snazzy_blue}"
set-face global StatusCursor       "%opt{snazzy_ui_12},%opt{snazzy_cursor_bg}"
set-face global Prompt             "%opt{snazzy_line_base3},%opt{snazzy_line_base01}"

# code
set-face global value              "%opt{snazzy_yellow},default"
set-face global type               "%opt{snazzy_cyan},default+b"
set-face global identifier         "%opt{snazzy_blue},default+b"
set-face global string             "%opt{snazzy_yellow},default"
set-face global error              "%opt{snazzy_red},default"
set-face global keyword            "%opt{snazzy_magenta},default+b"
set-face global comment            "%opt{snazzy_ui_8},default+i"
set-face global meta               "%opt{snazzy_yellow},default"
set-face global module             string
set-face global operator           "%opt{snazzy_magenta},default"
set-face global variable           default
set-face global attribute          identifier
set-face global function           identifier
set-face global builtin            identifier

# text
set-face global title              "%opt{snazzy_blue},default+b"
set-face global header             "%opt{snazzy_cyan},default+b"
set-face global mono               "%opt{snazzy_green},default"
set-face global block              "%opt{snazzy_magenta},default"
set-face global link               "%opt{snazzy_blue},default"
set-face global bullet             "%opt{snazzy_blue},default"
set-face global list               "%opt{snazzy_yellow},default"

# cursor line
add-highlighter global/ line '%val{cursor_line}' "default,%opt{snazzy_ui_9}"

# columns
add-highlighter global/ column 79 "default,%opt{snazzy_ui_9}"
# add-highlighter global/ column 80 "default,%opt{snazzy_ui_9}"
# add-highlighter global/ column 81 "default,%opt{snazzy_ui_9}"
add-highlighter global/ column 119 "default,%opt{snazzy_ui_9}"
# add-highlighter global/ column 120 "default,%opt{snazzy_ui_9}"
# add-highlighter global/ column 121 "default,%opt{snazzy_ui_9}"

hook global WinSetOption .* %{
  set-face global DiagnosticError error
  set-face global DiagnosticWarning "%opt{snazzy_cyan},default"
  set-face global Reference "default,%opt{snazzy_ui_9}"
}

hook global ModuleLoaded powerline %{
  set-option global powerline_color07 "%opt{snazzy_ui_9}"        # fg: mode-info
  set-option global powerline_color08 "%opt{snazzy_blue}"        # base background
  set-option global powerline_color00 "%opt{snazzy_ui_2}"        # fg: bufname
  set-option global powerline_color03 "%opt{snazzy_line_base01}" # bg: bufname
  set-option global powerline_color10 "%opt{snazzy_line_base0}"  # fg: filetype
  set-option global powerline_color11 "%opt{snazzy_ui_9}"        # bg: filetype
  set-option global powerline_color02 "%opt{snazzy_line_base0}"  # fg: git
  set-option global powerline_color04 "%opt{snazzy_ui_9}"        # bg: git
  set-option global powerline_color05 "%opt{snazzy_line_base2}"  # fg: position
  set-option global powerline_color01 "%opt{snazzy_line_base01}" # bg: position
  set-option global powerline_color06 "%opt{snazzy_ui_9}"        # fg: line-column, lsp
  set-option global powerline_color09 "%opt{snazzy_line_base1}"  # bg: line-column, lsp
}

hook global ModuleLoaded search-highlighter %{
  set-face global Search "%opt{snazzy_black},%opt{snazzy_yellow}+f"
}
