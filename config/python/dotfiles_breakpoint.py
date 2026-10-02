from IPython.terminal.embed import InteractiveShellEmbed
from IPython.terminal.ipapp import load_default_config


def ipython(*, header="", **kwargs):
    config = load_default_config()
    colors = config.TerminalInteractiveShell.get(
        "colors", config.InteractiveShell.get("colors", "neutral")
    )
    shell = InteractiveShellEmbed(config=config, colors=colors)
    shell(header=header, stack_depth=2, **kwargs)
