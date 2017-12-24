FROM armhf/alpine:latest
MAINTAINER Ryan_Newman <15244909057.ww@gmail.com>

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
