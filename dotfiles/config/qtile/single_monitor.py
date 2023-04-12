from libqtile import bar, layout, widget, qtile
from libqtile.config import Click, Drag, Group, Key, KeyChord, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

mod      = "mod1"
terminal = "alacritty"
browser  = "brave"
fileManager = "thunar"
sound    = "pavucontrol"
launcher = "dmenu_run -l 10 -nb '#000000' -nf '#ffffff' -sb '#ffffff' -sf '#000000' -fn 'some font'"
lock     = "slock"
mediaPlayer = "vlc"

colours = {
    "turquoise1": "#00ffff",
    "turquoise2": "#009090",
    "turquoise3": "#004444",
    "turquoise4": "#002222",
    "red1": "#ff0000",
    "red2": "#aa0000",
    "red3": "#440000",
    "red4": "#220000"
}










#################################################################################
#                                  My Layouts                                   #
#################################################################################


myMonadTall = layout.MonadTall(
    name='Tall',
    ratio=0.65,
    max_ratio=0.90,
    min_ratio=0.10,
    change_ratio=0.05,
    margin=0,
    border_focus=colours["red2"]
)
myMax = layout.Max(
    name='Max'
)
myTile = layout.Tile()
myColumns = layout.Columns(
    name='Cols',
    border_focus=colours["red2"],
    #border_focus_stack=["#d75f5f", "#8f3d3d"],
    border_focus_stack=colours["turquoise2"],
    border_normal=colours["red3"],
    border_normal_stack=colours["turquoise3"],
    border_on_single=True,
    border_width=3
)


#################################################################################
#                                   My Groups                                   #
#################################################################################

groups = [
    Group(
        name="1 (main)",
        layouts=[
            myMonadTall,
            myMax,
        ]
    ),
    Group(
        name="2 (web)",
        layouts=[
            myColumns,
            myMax
        ]
    ),
    Group(
        name="3 (dev)",
        layouts=[
            myMonadTall,
            myMax
        ]
    ),
    Group(
        name="4 (dev)",
        layouts=[
            myMonadTall,
            myMax
        ]
    ),
    Group(
        name="5 (spare)",
        layouts=[
            myMonadTall,
            myMax
        ]
    ),
]



#################################################################################
#                                Keybindings                                    #
#################################################################################

keys = [

    ## fn keys ##
    Key([], "XF86MonBrightnessDown", lazy.spawn("xbacklight -dec 10")),
    Key([], "XF86MonBrightnessUp",   lazy.spawn("xbacklight -inc 10")),
    Key([], "XF86AudioMute",         lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")),
    Key([], "XF86AudioLowerVolume",  lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -10%")),
    Key([], "XF86AudioRaiseVolume",  lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +10%")),


    ## Switch focus ##
    Key([mod], "h",                  lazy.layout.left()),
    Key([mod], "l",                  lazy.layout.right()),
    Key([mod], "j",                  lazy.layout.down()),
    Key([mod], "k",                  lazy.layout.up()),
    Key([mod], "space",              lazy.layout.left()),
    Key([mod], "q",                  lazy.window.kill()),


    ## Move windows ##
    Key([mod, "shift"], "h",         lazy.layout.shuffle_left()),
    Key([mod, "shift"], "l",         lazy.layout.shuffle_right()),
    Key([mod, "shift"], "j",         lazy.layout.shuffle_down()),
    Key([mod, "shift"], "k",         lazy.layout.shuffle_up()),
    Key([mod, "shift"], "space",     lazy.layout.shuffle_left()),


    ## Change window sizes ##
    # MonadTall
    Key([mod, "control"], "h",       lazy.layout.shrink()),
    Key([mod, "control"], "l",       lazy.layout.grow()),
    Key([mod, "control"], "n",       lazy.layout.normalize()),
    Key([mod, "control"], "m",       lazy.layout.maximize()),
    # Columns
    Key([mod, "control"], "j",       lazy.layout.grow_down()),
    Key([mod, "control"], "k",       lazy.layout.grow_up()),
    # All
    Key([mod, "control"], "f",       lazy.window.toggle_fullscreen()),


    ## Stuff ##
    Key([mod, "shift"],   "Return",  lazy.layout.toggle_split()),
    Key([mod],            "Tab",     lazy.next_layout()), # toggle between layouts
    Key([mod, "control"], "r",       lazy.reload_config()),
    Key([mod, "control"], "q",       lazy.shutdown()),
    Key([mod],            "r",       lazy.spawncmd()),


    ## Essential Programs ##
    Key([mod], "b",                  lazy.spawn(browser)),
    Key([mod], "p",                  lazy.spawn(launcher)),
    Key([mod], "s",                  lazy.spawn(sound)),
    Key([mod], "m",                  lazy.spawn(mediaPlayer)),
    Key([mod], "f",                  lazy.spawn(fileManager)),
    Key([mod], "BackSpace",          lazy.spawn(lock)),
    Key([mod], "Return",             lazy.spawn(terminal)),


    ## Groups ##
    KeyChord([mod, "control"], "g", [
        Key([], "l",         lazy.screen.next_group()),
        Key([], "h",         lazy.screen.prev_group())
        ],
        mode = "Group"
    ),


    ## Screenshots ##
    KeyChord([mod, "control"], "s", [
        Key([], "Return",    lazy.spawn("my_screenshot.sh")),
        Key([], "g",         lazy.spawn("flameshot gui"))
        ],
        mode = "Screenshot"
    )
]


for i, g in enumerate(groups):
    keys.extend(
        [
            Key([mod], str(i + 1),          lazy.group[g.name].toscreen()),
            Key([mod, "shift"], str(i + 1), lazy.window.togroup(g.name, switch_group=False)),
        ]
    )





# global layouts list
layouts = [
    layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4),
    layout.MonadTall(),
    layout.Max(),
    layout.Stack(num_stacks=2),
    layout.Bsp(),
    layout.Matrix(),
    layout.MonadWide(),
    layout.RatioTile(),
    layout.Tile(),
    layout.TreeTab(),
    layout.VerticalTile(),
    layout.Zoomy(),
]




widget_defaults = dict(
    font="sans",
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()



barFontSize = 18
screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                    fontsize=barFontSize,
                    highlight_method='text',
                    active='888888',
                    inactive='222222',
                    this_current_screen_border='00ffff'
                ),
                widget.TextBox(text="| ", fontsize=20),
                widget.CurrentLayout(fontsize=barFontSize, foreground='007705'),
                widget.Prompt(fontsize=barFontSize),
                widget.TextBox(text="| ", fontsize=20),
                widget.Chord(
                    chords_colors={"launch": ("#ff0000", "#ffffff")},
                    name_transform=lambda name: name.upper(),
                    fontsize=15
                ),
                widget.Spacer(),
                widget.Systray(fontsize=barFontSize),
                #widget.Battery(fontsize=15, foreground='888888'),
                widget.TextBox(text=" | ", fontsize=20),
                widget.Clock(format="%d-%m-%Y  (%a)  %H:%M:%S", fontsize=barFontSize, foreground='888888'),
            ],
            size=28,
            opacity=1.0
            #border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            #border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
    ),
]





# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]




dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
