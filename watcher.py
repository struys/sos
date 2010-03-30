"""
watcher.py - advanced filesystem watcher

Maintain directory state in memory to be able to detect which file is modified,
created or deleted. Outputs events on stdout.

Copyright 2009 Nicolas Dumazet <nicdumz@gmail.com>

This library is free software; you can redistribute it and/or
modify it under the terms of the MIT License.
"""
import os
import pyfsevents
import httplib

DOMAIN = 'localhost:8080'
REFRESH_SERVLET = '/conf/refresh-servlets'

def watch(basepath):

    def callback(path, isrec):
		print "modified"
		conn = httplib.HTTPConnection(DOMAIN)
		conn.request("GET", REFRESH_SERVLET)
		r1 = conn.getresponse()
		print r1.status
		conn.close()


    pyfsevents.registerpath(basepath, callback)
    pyfsevents.listen()

if __name__ == '__main__':
    import sys

    if len(sys.argv) != 2:
        print "    Usage: python watcher.py path"
        sys.exit(-1)

    watch(sys.argv[1])
