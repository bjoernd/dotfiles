#!/usr/bin/python

"""
Take as input the file name of a Linux system call definition header (e.g.,
unistd_32.h) and either a syscall number (hex or decimal) or a part of a
syscall name. Look up the system call in the file and pretty-print the
number->call mapping(s).
"""

import sys
import subprocess

if len(sys.argv) != 3:
    print "Usage: lxsysdef <filename> <syscall number or part of its name>"
    exit(1)

filename = sys.argv[1]
value    = sys.argv[2]

# if parameter is a hex number, convert it to decimal as this
# is the number we'll find in the file.
if value.startswith("0x"):
    value = str(int(value, 16))

# grep for occurrences of the number within the file
grepcmd = "cat %s | grep define | grep %s" % (filename, value)
# if we are looking for a syscall number, we make sure that we only grep
# for those parts where the number is at the end (in order to reduce
# output)
if (value.isdigit()):
    grepcmd += "$"

grepret = subprocess.check_output(grepcmd, shell=True).split("\n")

print filename
for l in grepret:
    if l != "":
        data = l.split()
        if value.isdigit() and data[2] != value:
            continue
        else:
            print "%20s \033[32m%5s\033[0m" % (data[1][5:], data[2])
