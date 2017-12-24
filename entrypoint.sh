#!/bin/sh

/sslocal.sh
nohup /usr/sbin/privoxy /etc/privoxy/config >/dev/null 2>&1 &
/kcptun.sh
