from ranger.gui.colorscheme import ColorScheme
from ranger.gui.color import (
    black, blue, cyan, green, magenta, red, white, yellow, default,
    normal, bold, blink, reverse, underline, invisible, dim,
    default_colors,
)

class Shk(ColorScheme):
    progress_bar_color = yellow
    def use(self, context):  # pylint: disable=too-many-branches,too-many-statements
        fg, bg, attr = default_colors

        if context.reset:
            return default_colors
        if context.error:
            bg = red
        elif context.empty:
            bg = yellow

        if context.selected:
            attr = reverse | blink
        else:
            attr = normal
        if context.marked:
            attr |= bold

        if context.in_browser or context.main_column:
            if context.container or context.directory:
                attr |= bold
                fg = blue
            elif context.executable:
                fg = red
            elif context.media:
                fg = green
            elif context.socket or context.fifo or context.device:
                fg = magenta
            elif context.link:
                fg = blue

        if context.badinfo:
            if attr & reverse:
                bg = magenta
            else:
                fg = magenta

        return fg, bg, attr
