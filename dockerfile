FROM debian
ADD * ./

RUN apt-get update
RUN apt-get -y install python3.7.3 python3-distutils make gcc

RUN chmod 777 ssr-install.sh
RUN bash ssr-install.sh
RUN cp ssr.json /etc/ssr.json
EXPOSE 7000-7030/tcp
CMD  ["python3","/usr/local/ssr/shadowsocks/server.py", "-c", "/etc/ssr.json"]