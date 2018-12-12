#!/usr/bin/env bash

set -e

chown -R $USER:$USER /root/.vnc
chmod u=rw,g=,o= /root/.vnc/passwd

/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
exec bash -c "vncserver :1 -geometry $RESOLUTION -depth 24 && tail -F /root/.vnc/*.log"

exec "$@"
