#!/usr/bin/env python3

import click
import datetime
import json
import os
import re
import shutil
import sys

from IPython import embed as breakpoint
from functional import seq

ENCODING = 'utf-8'
SCRIPT_PATH = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


class Context:
    def __init__(self, script_path=None):
        self.script_path = script_path

        class Config(dict):
            pass

        self.config = Config()
        self.config.__dict__ = self.config

    def get(self, key: str):
        return self.config[key]

    def set(self, key: str, value):
        self.config[key] = value

    def _log_level(self, level, *args, **kwargs):
        timestamp = datetime.datetime.now()
        click.echo(' '.join((f'[{timestamp}] {level}:', *args, )), **kwargs)

    def log(self, *args, **kwargs):
        self._log_level('INFO', *args, **kwargs)

    def logd(self, *args, **kwargs):
        if self.config.debug:
            self._log_level('DEBUG', *args, **kwargs)


pass_context = click.make_pass_decorator(Context)


@click.group(invoke_without_command=True)
# @click.option('--config',
#               type=click.File('r', encoding=ENCODING),
#               default=lambda: os.path.join(SCRIPT_PATH, 'config.json'))
@click.option('--out',
              type=click.Path(file_okay=False, writable=True,
                              resolve_path=True),
              default=lambda: os.path.join(SCRIPT_PATH, 'out'))
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
    context = ctx.obj = Context(script_path=SCRIPT_PATH)
    context.set('debug', debug)
    context.set('interactive', interactive)

    cfg = context.config
    cfg.out_dir = out

    context.log('Started')

    if ctx.invoked_subcommand is not None:
        context.logd(f'cli: I am about to invoke {ctx.invoked_subcommand}')
        return

    context.logd('cli: I was invoked without subcommand')
    ctx.invoke(subcommand)
    context.log('Finished')

    if context.get('interactive'):
        breakpoint()


@cli.command()
@pass_context
@click.pass_context
def subcommand(ctx, context):
    cfg = context.config
    context.log(f'subcommand: Hello World')
    context.logd(f'subcommand: (interactive={cfg.interactive},'
                 f'debug={cfg.debug})')


if __name__ == '__main__':
    cli()
