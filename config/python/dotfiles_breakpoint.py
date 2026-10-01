from IPython import embed
from IPython.terminal.ipapp import load_default_config


def ipython(*, header="", compile_flags=None, **kwargs):
    config = load_default_config()
    kwargs.setdefault("colors", config.InteractiveShell.colors)
    return embed(header=header, compile_flags=compile_flags, **kwargs)
