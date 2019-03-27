#!/bin/bash
cd /dummy_server
nohup python -m SimpleHTTPServer 3000 &
cd /app
Xvfb -screen 0 800x600x16 -ac &
DISPLAY=:0 ratpoison &
x11vnc -create -forever -nopw -rfbport 5910