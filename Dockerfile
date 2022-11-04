FROM deepnox/python-ta-lib-pandas:1.4.3_talib0.4.24_python3.10.6_alpine3.16

WORKDIR /root/StockNotifier
# install zsh and gcc for python modules
COPY StockNotifier/requirements.txt /root/StockNotifier/
COPY etc /etc/
RUN apk add --no-cache --virtual .build-deps \
  linux-headers \
  gcc \
  g++ \
  make && \
  pip --no-cache-dir install -r requirements.txt && \
# Add yacron for running as server
  pip --no-cache-dir install yacron

COPY StockNotifier/main.py StockNotifier/example/config.json /root/StockNotifier/
COPY StockNotifier/lib /root/StockNotifier/lib


CMD ["yacron", "-c", "/etc/crontab.yaml"]
