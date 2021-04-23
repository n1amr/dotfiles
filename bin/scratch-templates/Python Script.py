#!/usr/bin/env python3

import argparse
import logging
import os
import sys
import time

THIS_DIR = os.path.abspath(os.path.dirname(__file__))

log = logging.getLogger(__name__)


def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('input_files', nargs='+', type=str)

    args = parser.parse_args()
    return args


def main(args: argparse.Namespace):
    log.info(f'Args: {args}')

    return 0


def setup_logging():
    short_logging_format = '[%(asctime)s.%(msecs)03d] %(levelname)-s: %(message)s'
    long_logging_format = f'{short_logging_format} --- %(name)s at %(filename)s:%(lineno)d'
    time_format = '%Y-%m-%d %H:%M:%S'
    log_file = os.path.join(THIS_DIR, 'log.txt')

    logging.basicConfig(
        format=short_logging_format,
        level=os.environ.get('LOGLEVEL', 'info').upper(),
        datefmt=time_format,
        stream=sys.stdout,
    )
    logging.Formatter.converter = time.gmtime

    os.makedirs(os.path.dirname(log_file), exist_ok=True)
    file_handler = logging.FileHandler(log_file)
    file_handler.setLevel(logging.DEBUG)
    file_handler.setFormatter(logging.Formatter(short_logging_format))
    root_logger = logging.getLogger()
    root_logger.addHandler(file_handler)

    log.info(f'Logging to file: {log_file}')


if __name__ == '__main__':
    setup_logging()
    args = parse_args()
    try:
        sys.exit(main(args))
    except Exception as e:
        log.exception(e)
        sys.exit(1)