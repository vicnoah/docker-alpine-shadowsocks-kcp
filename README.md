使用Docker基于alpine linux将shadowsocks转为socks5与http   

一.使用方法   

1.使用docker build -t 镜像名:版本号 路径   

例子：
```
docker build -t sslocal:latest .
```   

表示使用当前路径的Dockerfile文件生成镜像   

2.运行容器   


```
docker run -ti --restart=always --name sslocal    
-d -p 8118:8118 -p 1080:1080 -e KCP_SERVER_IP=服务器ip地址    
-e KCP_SERVER_PORT=服务器kcp端口 -e KCP_LOCAL_LISTEN_PORT=kcp本地监听端口 
-e KCP_LOCAL_MODE=kcp工作模式   
-e SS_SERVER_PASSWD=服务器shadowsocks加密密码 -e SS_SERVER_ENCRYPT_METHOD=aes-256-cfb--服务器shadowsocks加密方式    
-e SS_LOCAL_PORT=1080--本地socks5监听端口 sslocal:latest
```
