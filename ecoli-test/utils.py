import tempfile
import os.path
import sys
from cStringIO import StringIO

class TempStuff(object):
    def __init__(self, suff=''):
        self.dirname = tempfile.mkdtemp(suffix=suff)

    def filename(self, name):
        path = os.path.join(self.dirname, name)
        return path
