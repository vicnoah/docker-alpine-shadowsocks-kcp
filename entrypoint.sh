#!/bin/sh

/kcptun.sh
nohup /usr/sbin/privoxy /etc/privoxy/config &
/sslocal.sh
