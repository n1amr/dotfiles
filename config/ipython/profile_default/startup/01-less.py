import subprocess


class __Less:
    def less(self, obj):
        process = subprocess.Popen(['less'], stdin=subprocess.PIPE)
        data = str(obj).encode()

        try:
            process.stdin.write(data)
            process.communicate()
        except IOError as e:
            pass

    def __ror__(self, data):
        self.less(data)

    def __call__(self, data):
        self.less(data)

less = __Less()
