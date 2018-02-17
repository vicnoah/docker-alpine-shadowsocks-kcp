FROM alpine:latest
MAINTAINER Ryan_Newman <15244909057.ww@gmail.com>

#RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories

ENV SS_SERVER_LISTEN_PORT=8443
ENV SS_SERVER_PASSWD=9776586516
ENV SS_SERVER_ENCRYPT_METHOD=aes-256-cfb
ENV KCP_SERVER_LISTEN_TARGET_IP=127.0.0.1
ENV KCP_SERVER_LISTEN_TARGET_PORT=8443
ENV KCP_SERVER_PORT=9443
ENV KCP_KEY=secret
ENV KCP_SERVER_CRYPT=aes-128
ENV KCP_MTU=1350
ENV KCP_SERVER_MODE=fast2
ENV KCP_SERVER_SNDWND=2048

#shadowsocks监听端口
#shadowsocks密码
#shadowsocks加密方式
#kcp服务端监听的远程ip，这里为本机
#kcp服务端监听的远程端口，这里为shadowsocks服务端的端口
#kcp服务器端监听端口，udp协议端口
#kcp工作模式，一般使用fast2

RUN apk update
RUN apk upgrade

WORKDIR /
ADD ./ssserver /ssserver
ADD ./kcptun.zip /kcptun.zip
RUN unzip /kcptun.zip
RUN rm -rf /kcptun.zip
RUN rm -rf /client_linux_amd64
ADD ./ssserver.sh /ssserver.sh
ADD ./kcptun.sh /kcptun.sh
ADD ./entrypoint.sh /entrypoint.sh

RUN chmod +x /ssserver
RUN chmod +x /server_linux_amd64
RUN chmod +x /ssserver.sh
RUN chmod +x /kcptun.sh
RUN chmod +x /entrypoint.sh

CMD ["/bin/sh -c '/entrypoint.sh && tail -f /dev/null'"]
