#!/bin/sh


KCP_SERVER_IP=127.0.0.1
KCP_SERVER_PORT=${KCP_SERVER_PORT}
KCP_LOCAL_LISTEN_PORT=${KCP_LOCAL_LISTEN_PORT}
KCP_LOCAL_MODE=${KCP_LOCAL_MODE}
ARCH=${ARCH}
if [ "$ARCH" = "arm7"];then
./client_linux_arm7 -r "$KCP_SERVER_IP:$KCP_SERVER_PORT" -l ":$KCP_LOCAL_LISTEN_PORT" -mode $KCP_LOCAL_MODE
else
if [ "$ARCH" = "arm6"];then
./client_linux_arm6 -r "$KCP_SERVER_IP:$KCP_SERVER_PORT" -l ":$KCP_LOCAL_LISTEN_PORT" -mode $KCP_LOCAL_MODE
else
if [ "$ARCH" = "arm5"];then
./client_linux_arm5 -r "$KCP_SERVER_IP:$KCP_SERVER_PORT" -l ":$KCP_LOCAL_LISTEN_PORT" -mode $KCP_LOCAL_MODE
fi
fi
fi
