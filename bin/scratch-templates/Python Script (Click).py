#!/usr/bin/env python3

import click
import json
import os
import re
import shutil
import sys

from IPython import embed as breakpoint
from functional import seq

ENCODING = 'utf-8'
CURRENT_PATH = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


class Config(dict):
    pass


class Context:
    def __init__(self, current_path=None, out_dir=None):
        self.current_path = current_path

        self.config = Config()
        self.config.__dict__ = self.config

        self.config.out_dir = out_dir


pass_context = click.make_pass_decorator(Context)


@click.group(invoke_without_command=True)
# @click.option('--config',
#               type=click.File('r', encoding=ENCODING),
#               default=lambda: os.path.join(CURRENT_PATH, 'config.json'))
@click.option('--out',
              type=click.Path(file_okay=False, writable=True,
                              resolve_path=True),
              default=lambda: os.path.join(CURRENT_PATH, 'out'))
@click.option('-d', '--debug', default=False, is_flag=True)
@click.option('-i', '--interactive', default=False, is_flag=True)
# @click.argument('input', default='')
@click.pass_context
def cli(
    ctx,
    # config,
    out,
    interactive,
    debug,
    # input,
):

    ctx.obj = Context(current_path=CURRENT_PATH, out_dir=out)
    cfg = ctx.obj.config

    cfg.interactive = interactive
    cfg.debug = debug

    if ctx.invoked_subcommand is None:
        click.echo('cli: I was invoked without subcommand')
        ctx.invoke(hello)
    else:
        click.echo(f'cli: I am about to invoke {ctx.invoked_subcommand}')


@cli.command()
@pass_context
def hello(context):
    cfg = context.config
    click.echo(f'hello: Hello World')
    click.echo(f'hello: (interactive={cfg.interactive}, debug={cfg.debug})')


if __name__ == '__main__':
    cli()
