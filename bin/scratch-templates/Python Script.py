#!/usr/bin/env python

import sys


def main(*args):
    print('script: ' + args[0])
    print('args:')
    for arg in args[1:]:
        print(arg)

    return 0


if __name__ == '__main__':
    sys.exit(main(*sys.argv))
