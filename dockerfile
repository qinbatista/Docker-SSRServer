FROM debian
ADD * ./



RUN apt-get update
RUN apt-get -y install python3 python3-distutils

COPY libsodium-1.0.10.tar.gz ./libsodium-1.0.10.tar.gz
RUN tar xzvf ./libsodium-1.0.10.tar.gz
RUN ./libsodium-1.0.10/configure
RUN make -j8 && make install
RUN echo /usr/local/lib > /etc/ld.so.conf.d/usr_local_lib.conf
RUN ldconfig

RUN chmod 777 ssr-install.sh
RUN bash ssr-install.sh
RUN cp ssr.json /etc/ssr.json
EXPOSE 7000-7030/tcp
CMD  ["python3","/usr/local/ssr/shadowsocks/server.py", "-c", "/etc/ssr.json"]