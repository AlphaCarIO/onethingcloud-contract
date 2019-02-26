FROM leochan007/ubuntu1804_base

LABEL MAINTAINER leo chan <leochan007@163.com>

ENV DEBIAN_FRONTEND noninteractive

COPY server-wallet-linux /root/server-wallet-linux

WORKDIR /root/server-wallet-linux/sbin

CMD ./wallet.sh start; tail -f /dev/null
