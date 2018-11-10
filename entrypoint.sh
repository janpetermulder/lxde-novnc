#!/usr/bin/env bash

set -e

chown -R $USER:$USER /root/.vnc
chmod u=rw,g=,o= /root/.vnc/passwd

exec "$@"