FROM debian
ADD * ./

RUN apt-get update
RUN apt install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev curl libbz2-dev
RUN apt-get -y install make gcc

RUN curl -O https://www.python.org/ftp/python/3.7.3/Python-3.7.3.tar.xz
RUN tar -xf Python-3.7.3.tar.xz
RUN cd Python-3.7.3
RUN ./configure --enable-optimizations
RUN make -j 8
RUN make altinstall

RUN chmod 777 ssr-install.sh
RUN bash ssr-install.sh
RUN cp ssr.json /etc/ssr.json
EXPOSE 7000-7030/tcp
CMD  ["python3","/usr/local/ssr/shadowsocks/server.py", "-c", "/etc/ssr.json"]