import os
import subprocess

from libqtile import bar, hook, qtile, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.layout.max import Max
from libqtile.layout.columns import Columns
from libqtile.layout.stack import Stack
from libqtile.layout.zoomy import Zoomy
from libqtile.layout.floating import Floating
from libqtile.lazy import lazy

from qtile_extras.widget.decorations import BorderDecoration

# * Variables
MOD = "mod4"
CTRL = "control"
SHIFT = "shift"
ENTER = "Return"

BROWSER = "brave"

TEXT = "xed"
CODE = "code"

FILE = "pcmanfm -n"
TERMINAL = "kitty"

LOCK = "betterlockscreen -l dimblur --display 1"

ROFI_LAUNCHER = "rofi \
    -show drun \
    -modi run,drun,ssh \
    -scroll-method 0 \
    -drun-match-fields all \
    -drun-display-format \"{name}\" \
    -no-drun-show-actions \
    -terminal kitty \
    -theme .config/rofi/config/launcher.rasi"

BRIGHTNESS_STEP = 10


@hook.subscribe.startup_once
def autostart():
    script = os.path.expanduser("~/.config/qtile/autostart.sh")
    subprocess.run([script], check=False)


keys = [
    #* Qtile Key Bindings
    Key(
        [MOD, CTRL], "r",
        lazy.reload_config(),
        desc="Reload the config"
    ),
    Key(
        [MOD, SHIFT], "q",
        lazy.shutdown(),
        desc="Shutdown Qtile"
    ),

    #* Client Key Bindings
    Key(
        [MOD], "j",
        lazy.layout.previous(),
        desc="Move focus to previous window"
    ),
    Key(
        [MOD], "k",
        lazy.layout.next(),
        desc="Move focus to next window"
    ),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([MOD, "shift"], "h", lazy.layout.shuffle_left(),
        desc="Move window to the left"),
    Key([MOD, "shift"], "l", lazy.layout.shuffle_right(),
        desc="Move window to the right"),
    Key([MOD, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([MOD, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([MOD, "control"], "h", lazy.layout.grow_left(),
        desc="Grow window to the left"),
    Key([MOD, "control"], "l", lazy.layout.grow_right(),
        desc="Grow window to the right"),
    Key([MOD, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([MOD, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),

    Key([MOD], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [MOD, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),

    # Toggle between different layouts as defined below
    Key([MOD], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([MOD], "q", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [MOD],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    Key([MOD], "t", lazy.window.toggle_floating(),
        desc="Toggle floating on the focused window"),

    Key([MOD], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),

    #* Launchers
    Key(
        [MOD], "b",
        lazy.spawn(BROWSER),
        desc="Launch Browser"
    ),

    Key(
        [MOD], "c",
        lazy.spawn(CODE),
        desc="Launch IDE"
    ),
    Key(
        [MOD, SHIFT], "c",
        lazy.spawn(TEXT),
        desc="Launch Text Editor"
    ),

    Key(
        [MOD], "e",
        lazy.spawn(FILE),
        desc="Launch File"
    ),

    Key(
        [MOD], ENTER,
        lazy.spawn(TERMINAL),
        desc="Launch terminal"
    ),

    Key(
        [MOD], "p",
        lazy.spawn(ROFI_LAUNCHER),
        desc="Launch prompt"
    ),

    #* Hotkeys

    # Brightness
    Key(
        [], "XF86MonBrightnessUp",
        lazy.spawn(f"brightnessctl s +{BRIGHTNESS_STEP}%")
    ),
    Key(
        [MOD], "XF86MonBrightnessUp",
        lazy.spawn(f"brightnessctl s {BRIGHTNESS_STEP}%-")
    ),
    Key(
        [], "XF86MonBrightnessDown",
        lazy.spawn(f"brightnessctl s {BRIGHTNESS_STEP}%-")
    ),

    # Media Controls
    Key(
        [], "XF86AudioPlay",
        lazy.spawn("playerctl play-pause || mpc toggle")
    ),
    Key(
        [MOD], "XF86AudioMute",
        lazy.spawn("playerctl play-pause || mpc toggle")
    ),

    Key(
        [], "XF86AudioNext",
        lazy.spawn("playerctl next || mpc next")
    ),
    Key(
        [MOD], "XF86AudioRaiseVolume",
        lazy.spawn("playerctl next || mpc next")
    ),

    Key(
        [], "XF86AudioPrev",
        lazy.spawn("playerctl previous || mpc prev")
    ),
    Key(
        [MOD], "XF86AudioLowerVolume",
        lazy.spawn("playerctl previous || mpc prev")
    )
]

groups = []
group_names = ["1", "2", "3", "4", "5", "6", "7", "8", "9",]

group_labels = ["www", "dev", "sys", "doc",
                "vbox", "chat", "mus", "vid", "gfx",]


group_layouts = ["columns", "columns", "columns", "columns",
                 "columns", "columns", "columns", "columns", "columns"]

for name, label, layout in zip(group_names, group_labels, group_layouts):
    groups.append(
        Group(
            name=name,
            layout=layout.lower(),
            label=label,
        )
    )

for g in groups:
    keys.extend(
        [
            # mod1 + group number = switch to group
            Key(
                [MOD],
                g.name,
                lazy.group[g.name].toscreen(),
                desc=f"Switch to group {g.name}",
            ),
            # mod1 + shift + group number = switch to & move focused window to group
            Key(
                [MOD, "shift"],
                g.name,
                lazy.window.togroup(g.name, switch_group=False),
                desc="Switch to & move focused window to group {}".format(
                    g.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + group number = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

colors = [
    ["#1e1e2eee", "#1e1e2ecc"],  # bg
    ["#cdd6f4", "#cdd6f4"],  # fg
    ["#1c1f24", "#1c1f24"],  # color01
    ["#f38ba8", "#f38ba8"],  # color02
    ["#a6e3a1", "#a6e3a1"],  # color03
    ["#fab387", "#fab387"],  # color04
    ["#89b4fa", "#89b4fa"],  # color05
    ["#cba6f7", "#cba6f7"],  # color06
    ["#89dceb", "#89dceb"]  # color15
]

layout_theme = {
    "border_width": 2,
    "margin": 4,
    "border_focus": colors[5],
    "border_normal": colors[0]
}


layouts = [
    Columns(**layout_theme,
            margin_on_single=0,
            insert_position=1),
    Max(border_width=0,
        margin=0),
    Stack(**layout_theme,
          num_stacks=2),
    Zoomy(**layout_theme),
]

widget_defaults = dict(
    font="Ubuntu Bold",
    fontsize=14,
    padding=0,
    background=colors[0],
)
extension_defaults = widget_defaults.copy()


def init_widgets_list():
    widgets_list = [
        widget.Image(
            filename="~/.config/qtile/icons/python-white.png",
            scale="False",
            mouse_callbacks={'Button1': lambda: qtile.cmd_spawn(TERMINAL)},
        ),
        widget.GroupBox(
            fontsize=13,
            margin_y=3,
            disable_drag=True,
            hide_unused=False,
            margin_x=4,
            padding_y=2,
            padding_x=3,
            borderwidth=3,
            active=colors[5],
            inactive=colors[1],
            rounded=False,
            highlight_color=colors[2],
            highlight_method="line",
            this_current_screen_border=colors[5],
            this_screen_border=colors[3],
            other_current_screen_border=colors[5],
            other_screen_border=colors[3],
        ),
        widget.Sep(
            foreground=colors[1],
            padding=2,
            size_percent=50
        ),
        widget.Spacer(length=8),
        # widget.TextBox(
        #     text='|',
        #     font="Ubuntu Mono",
        #     foreground=colors[1],
        #     padding=2,
        #     fontsize=14
        # ),
        widget.CurrentLayoutIcon(
            # custom_icon_paths = [os.path.expanduser("~/.config/qtile/icons")],
            foreground=colors[1],
            padding=0,
            scale=0.7
        ),
        widget.CurrentLayout(
            foreground=colors[1],
            padding=5
        ),
        widget.Sep(
            foreground=colors[1],
            padding=2,
            size_percent=50
        ),
        widget.Spacer(length=8),
        widget.WindowName(
            foreground=colors[5],
            max_chars=100
        ),
        widget.GenPollText(
            update_interval=300,
            func=lambda: subprocess.check_output(
                "printf $(uname -r)", shell=True, text=True),
            foreground=colors[3],
            fmt='❤  {}',
            decorations=[
                BorderDecoration(
                    colour=colors[3],
                    border_width=[0, 0, 2, 0],
                )
            ],
        ),
        widget.Spacer(length=8),
        widget.Volume(
            foreground=colors[7],
            fmt='🕫  Vol: {}',
            decorations=[
                BorderDecoration(
                    colour=colors[7],
                    border_width=[0, 0, 2, 0],
                )
            ],
        ),
        widget.Spacer(length=8),
        widget.Battery(
            foreground=colors[4],
            # fmt='🕫{}',
            format='{char}  Bat: {percent:1.0%}',
            charge_char='',
            discharge_char='',
            empty_char='',
            decorations=[
                BorderDecoration(
                    colour=colors[7],
                    border_width=[0, 0, 2, 0],
                )
            ],
        ),
        widget.Spacer(length=8),
        widget.Clock(
            foreground=colors[8],
            format="⏱  %a, %d %b - %H:%M",
            decorations=[
                BorderDecoration(
                    colour=colors[8],
                    border_width=[0, 0, 2, 0],
                )
            ],
        ),
        widget.Spacer(length=8)
    ]
    return widgets_list

# Monitor 1 will display ALL widgets in widgets_list. It is important that this
# is the only monitor that displays all widgets because the systray widget will
# crash if you try to run multiple instances of it.


def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    widgets_screen1.extend([
        widget.Systray(padding=3),
        widget.Spacer(length=8)])

    return widgets_screen1

# All other monitors' bars will display everything but widgets 22 (systray) and 23 (spacer).


def init_widgets_screen2():
    widgets_screen2 = init_widgets_list()
    return widgets_screen2


def init_screens():
    return [
        Screen(top=bar.Bar(widgets=init_widgets_screen1(),
               size=26, background="#00000000"),),
        Screen(top=bar.Bar(widgets=init_widgets_screen2(),
               size=26, background="#00000000"))
    ]


# screens = [
#     Screen(
#         bottom=bar.Bar(
#             [
#                 widget.CurrentLayout(),
#                 widget.GroupBox(),
#                 widget.Prompt(),
#                 widget.WindowName(),
#                 widget.Chord(
#                     chords_colors={
#                         "launch": ("#ff0000", "#ffffff"),
#                     },
#                     name_transform=lambda name: name.upper(),
#                 ),
#                 widget.TextBox("default config", name="default"),
#                 widget.TextBox("Press &lt;M-r&gt; to spawn",
#                                foreground="#d75f5f"),
#                 # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
#                 # widget.StatusNotifier(),
#                 widget.Systray(),
#                 widget.Clock(format="%Y-%m-%d %a %I:%M %p"),
#                 widget.QuickExit(),
#             ],
#             24,
#             # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
#             # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
#         ),
#         # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
#         # By default we handle these events delayed to already improve performance, however your system might still be struggling
#         # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
#         # x11_drag_polling_rate = 60,
#     ),
# ]

if __name__ in ["config", "__main__"]:
    screens = init_screens()
    widgets_list = init_widgets_list()
    widgets_screen1 = init_widgets_screen1()
    widgets_screen2 = init_widgets_screen2()


# Drag floating layouts.
mouse = [
    Drag([MOD], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([MOD], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([MOD], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *Floating.default_float_rules,
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
