#!/usr/bin/env python
import os

def log(var):
    print(var)
    return var

flatten       = lambda l: (item for sublist in l for item in sublist)
strip_nl_char = lambda val: val.rstrip('\n')
cli_run       = lambda cmd: map(strip_nl_char, os.popen(cmd).readlines())

find_c_files_str = 'find {} -name \*.h -print -o -name \*.cpp -print -o -name \*.c -print -o -name \*.cxx -print -o -name \*.hpp -print -o -name \*.hxx -print'.format
find_all_c_files =lambda path: cli_run(find_c_files_str(path))

def build_db(path):
    files = None
    print('Searching files to index')
    with open(path, 'r') as f:
        splited_lines = (line.rstrip('\n').split(' ') for line in f if not line.startswith('#'))
        files = set(flatten(map(find_all_c_files, (line[1] for line in splited_lines if len(line) > 1))))

    if files:
        with open('./cscope.files', 'w+') as f:
            f.write('\n'.join(files))
    print('start build DB')
    print(cli_run('cscope -RUbq 2>/dev/null'))
    print('finished')

build_db('./.BookMarks')


