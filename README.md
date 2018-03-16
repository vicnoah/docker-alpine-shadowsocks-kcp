# shadowsocks on kcptun容器包括服务器端，x86客户端，arm客户端
## 1.首先运行服务器端容器
### 1.方法一:本地构建镜像
```
docker build -t wuwengang/docker-alpine-shadowsocks-kcp:server_latest .
```
### 2.方法二:从dockerhub拉取镜像
```
docker pull wuwengang/docker-alpine-shadowsocks-kcp:server_latest
```
## 2.运行服务器端容器
### 1.首先了解服务器端参数的配置（有默认值得参数可以不必注入新值）
#### 1.SS_SERVER_LISTEN_IP=0.0.0.0             --可选参数，默认值0.0.0.0，服务器端shadowsocks监听ip
#### 2.SS_SERVER_LISTEN_PORT=8443              --可选参数，默认值8443，服务器端shadowsocks监听端口
#### 3.SS_SERVER_PASSWD=12345678               --必选参数，服务器端shadowsocks密码
#### 4.SS_SERVER_ENCRYPT_METHOD=aes-256-cfb    --可选参数，默认值aes-256-cfb,服务器端shadowsocks加密方式 
#### shadowsocks支持的加密方式都可以在这个参数输入
#### 5.KCP_SERVER_PORT=9443                    --可选参数，默认值9443，服务器端KCPTUN监听端口
#### 6.KCP_SERVER_MODE=fast2                   --可选参数，默认值fast2,KCP工作模式，KCP支持的模式都可以
#### 7.KCP_KEY=none                            --可选参数，KCP加密密钥，可以使用none（需与客户端一致）
#### 8.KCP_SERVER_CRYPT=none                   --可选参数，KCP加密密钥，为空可以使用none（需与客户端一致）
#### 赋值给这个参数
### 2.端口映射配置
#### 1.tcp/8443 如果需要直接连接服务器端使用shadowsocks服务，需要将SS_SERVER_LISTEN_PORT设置的端口做映射--非必选
#### 2.udp/8443 如果需要直接连接服务器端使用shadowsocks服务，需要将SS_SERVER_LISTEN_PORT设置的端口做映射--非必选
#### 3.udp/9443 KCP_SERVER_PORT必选做端口映射，需要映射的是UDP端口，因为kcptun使用UDP作为底层传输协议 --必选
### 3.第一种运行方式直接运行
```
docker run -ti --name ss_kcp_server --restart=always -d -p 8443:8443 -p 8443:8443/udp -p 9443:9443/udp
-e SS_SERVER_LISTEN_IP=0.0.0.0 -e SS_SERVER_LISTEN_PORT=8443 -e SS_SERVER_PASSWD=12345678
-e SS_SERVER_ENCRYPT_METHOD=aes-256-cfb -e KCP_SERVER_PORT=9443 -e KCP_SERVER_MODE=fast2
-e KCP_KEY=none -e KCP_SERVER_CRYPT=none
wuwengang/docker-alpine-shadowsocks-kcp:server_latest
```
### 4.第二张运行方式使用docker-compose方式运行
#### docker-compose格式
```
version: '2'
services:
        ss_kcp_server:
                image: wuwengang/docker-alpine-shadowsocks-kcp:server_latest
                restart: always
                environment:
                        SS_SERVER_LISTEN_IP: 0.0.0.0
                        SS_SERVER_LISTEN_PORT: 8443
                        SS_SERVER_PASSWD: 12345678
                        SS_SERVER_ENCRYPT_METHON: aes-256-cfb
                        KCP_SERVER_PORT: 9443
                        KCP_SERVER_MODE: fast2
                        KCP_KEY: none
                        KCP_SERVER_CRYRT: none
                ports:
                        - 8443:8443
                        - 8443:8443/udp
                        - 9443:9443/udp
```
#### 使用docker-compose -f ss_kcp_server up -d 运行
#### 使用docker-compose -f ss_kcp_server down 删除容器
## 3.运行客户端容器（客户端容器提供x86与arm架构的镜像，使用arm架构镜像请从仓库拉取代码自行构建）
### 1.方法一:本地构建镜像
```
docker build -t wuwengang/docker-alpine-shadowsocks-kcp:client_latest .
```
### 2.方法二:从dockerhub拉取镜像
```
docker pull wuwengang/docker-alpine-shadowsocks-kcp:client_latest
```
## 2.运行客户端容器
### 1.首先了解客户端参数的配置（有默认值得参数可以不必注入新值）
#### 1.KCP_SERVER_IP=192.168.1.100             --必选参数，kcp服务器ip地址
#### 2.KCP_SERVER_PORT=9443                    --必选参数，kcp服务器监听端口
#### 3.KCP_LOCAL_LISTEN_PORT=8338              --可选参数，客户端kcp代理监听端口
#### 4.SS_SERVER_PASSWD=12345678               --必选参数，shadowsocks加密密码，需要和服务器一样
#### 5.SS_SERVER_ENCRYPT_METHON=aes-256-cfb    --可选参数，默认值aes-256-cfb，shadowsocks加密方式，
#### 需要与服务器配置一样
#### 6.SS_LOCAL_PORT=1080                      --可选参数，默认值1080，本地socks5代理端口
### 2.端口映射配置
#### 1.tcp/8118 本地http代理端口                    --可选
#### 2.tcp/1080 本地socks5代理端口                  --可选，如果参数中更改了端口，请在这里也更改为对应端口
#### 3.tcp/8338 本地kcp代理端口                     --可选，如果参数中更改了端口，请在这里也更改为对应端口
#### 4.udp/8338 本地kcp代理端口                     --可选，如果参数中更改了端口，请在这里也更改为对应端口
#### 所有协议都会走kcp通道代理访问，其它shadowsocks的客户端，需要直接走kcp代理通道的话，需要将客户端容器对应
#### 的主机ip作为shadowsocks访问的ip，端口为客户端kcp端口，shadowsocks加密方式为服务器配置的加密方式，
#### shadowsocks密码为服务器配置的密码。
### 3.第一种运行方式直接运行
```
docker run -ti --name ss_kcp_client --restart=always -d -p 8118:8118 -p 1080:1080 -p 8338:8338
-p 8338:8338/udp -e KCP_SERVER_IP=192.168.1.100 -e KCP_SERVER_PORT=9443 -e KCP_LOCAL_LISTEN_PORT=8338
-e SS_SERVER_PASSWD=12345678 -e SS_SERVER_ENCRYPT_METHOND=aes-256-cfb -e SS_LOCAL_PORT=1080
-e KCP_KEY=none -e KCP_CLIENT_CRYPT=none
wuwengang/docker-alpine-shadowsocks-kcp:client_latest
```
### 4.第二张运行方式使用docker-compose方式运行
#### docker-compose格式
```
version: '2'
services:
        ss_kcp_client:
                image: wuwengang/docker-alpine-shadowsocks-kcp:client_latest
                restart: always
                environment:
                        KCP_SERVER_IP: 192.168.1.100
                        KCP_SERVER_PORT: 9443
                        KCP_LOCAL_LISTEN_POR: 8338
                        KCP_LOCAL_MODE: fast2
                        SS_SERVER_PASSWD: 12345678
                        ENCRYPT_METHON: ase-256-cfb
                        SS_LOCAL_PORT: 1080
                        KCP_KEY: none
                        KCP_CLIENT_CRYPT: none
                ports:
                        - 8118:8118
                        - 1080:1080
                        - 8338:8338
                        - 8338:8338/udp
```
#### 使用docker-compose -f ss_kcp_server up -d 运行
#### 使用docker-compose -f ss_kcp_server down 删除容器
## 最新改变
###    HTTP代理新增智能代理模式，国内常用域名都不走代理，国外域名全走代理，访问国内网站速度更加快速
###    ss通道添加udp传输支持,更新readme文件
