#!/bin/sh


KCP_SERVER_IP=${KCP_SERVER_IP}
KCP_SERVER_PORT=${KCP_SERVER_PORT}
SERVER_LINK="$KCP_SERVER_IP:$KCP_SERVER_PORT"
KCP_LOCAL_LISTEN_PORT=${KCP_LOCAL_LISTEN_PORT}
KCP_LOCAL_MODE=${KCP_LOCAL_MODE}
KCP_KEY=${KCP_KEY}
KCP_CLIENT_RCVWND=${KCP_CLIENT_RCVWND}
KCP_CLIENT_CRYPT=${KCP_CLIENT_CRYPT}
KCP_MTU=${KCP_MTU}
./client_linux_arm7 -r $SERVER_LINK -l ":$KCP_LOCAL_LISTEN_PORT" --key $KCP_KEY --crypt $KCP_CLIENT_CRYPT -mode $KCP_LOCAL_MODE --mtu $KCP_MTU --rcvwnd $KCP_CLIENT_RCVWND
