FROM leochan007/ubuntu1804_base

LABEL MAINTAINER leo chan <leochan007@163.com>

ENV DEBIAN_FRONTEND noninteractive
ENV VER v2

COPY server-wallet-linux /root/server-wallet-linux

WORKDIR /root/server-wallet-linux/sbin

RUN chmod a+x /root/server-wallet-linux/sbin/wallet.sh /root/server-wallet-linux/bin/server-wallet

CMD ./wallet.sh start; tail -f /dev/null
