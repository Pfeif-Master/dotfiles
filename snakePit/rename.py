import re
import os
import string

FIND    = 'othello'
REPLACE = 'otw'

files = [f for f in os.listdir() if re.match(r'%s.*'%FIND, f)]
for f in files:
    s = f.split('_', 1)
    newname = REPLACE + '_' + s[1]
    os.rename(f,newname)
