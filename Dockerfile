FROM armhf/alpine:latest
MAINTAINER Ryan_Newman <15244909057.ww@gmail.com>

ENV KCP_SERVER_IP=127.0.0.1
ENV KCP_SERVER_PORT=9443
ENV KCP_LOCAL_LISTEN_PORT=8338
ENV KCP_KEY=secret
ENV KCP_LOCAL_MODE=fast2
ENV KCP_CLIENT_RCVWND=2048
ENV KCP_CLIENT_CRYPT=aes-128
ENV KCP_MTU=1350
ENV SS_SERVER_PASSWD=123456
ENV SS_SERVER_ENCRYPT_METHOD=aes-256-cfb
ENV SS_LOCAL_PORT=1080

RUN apk update
RUN apk upgrade

RUN apk add py2-pip
RUN pip install shadowsocks
RUN apk add privoxy

WORKDIR /
ADD ./kcptun.zip /kcptun.zip
RUN unzip /kcptun.zip
RUN rm -rf /kcptun.zip
ADD ./sslocal/sslocal.sh /sslocal.sh
ADD ./privoxy/config /etc/privoxy/config
ADD ./privoxy/whitelistskip.action /etc/privoxy/whitelistskip.action
ADD ./kcptun.sh /kcptun.sh
ADD entrypoint.sh /entrypoint.sh


RUN chmod +x /sslocal.sh
RUN chmod +x /client_linux_arm5
RUN chmod +x /client_linux_arm6
RUN chmod +x /client_linux_arm7
RUN chmod +x /kcptun.sh
RUN chmod +x /entrypoint.sh


EXPOSE 1080 8118

CMD ["/entrypoint.sh"]
