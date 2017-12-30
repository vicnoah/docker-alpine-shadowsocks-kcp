#!/bin/sh

SS_SERVER_PORT=${KCP_LOCAL_LISTEN_PORT}
SS_SERVER_PASSWD=${SS_SERVER_PASSWD}
SS_SERVER_ENCRYPT_METHOD=${SS_SERVER_ENCRYPT_METHOD}
SS_LOCAL_PORT=${SS_LOCAL_PORT}

nohup sslocal -b $SS_SERVER:$SS_LOCAL_PORT -s [::1]$SS_SERVER_PORT -k $SS_SERVER_PASSWD -m $SS_SERVER_ENCRYPT_METHOD -u >/dev/null 2>&1 &
