#!/bin/sh


SS_SERVER=127.0.0.1
SS_SERVER_PORT=${KCP_LOCAL_LISTEN_PORT}
SS_SERVER_PASSWD=${SS_SERVER_PASSWD}
SS_SERVER_ENCRYPT_METHOD=${SS_SERVER_ENCRYPT_METHOD}
SS_LOCAL_PORT=${SS_LOCAL_PORT}

nohup sslocal -s $SS_SERVER -p $SS_SERVER_PORT -k $SS_SERVER_PASSWD -m $SS_SERVER_ENCRYPT_METHOD -b 0.0.0.0 -l $SS_LOCAL_PORT >/dev/null 2>&1 &
