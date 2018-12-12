#!/usr/bin/env bash

set -e

chown -R $USER:$USER /root/.vnc
chmod u=rw,g=,o= /root/.vnc/passwd

vncserver :1 -geometry $RESOLUTION -depth 24

exec "$@"
