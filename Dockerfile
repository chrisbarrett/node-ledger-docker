FROM node:6.10

VOLUME /mnt/config

EXPOSE 3000
EXPOSE 3001

RUN apt-get update && \
    apt-get install -y ledger && \
    apt-get clean -y && \
    apt-get autoclean -y && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt-lists/*

RUN git clone --depth 1 https://github.com/slashdotdash/node-ledger-web

WORKDIR node-ledger-web
RUN ln -s /mnt/config/config.json  config.json

RUN npm install
RUN npm install --global bower grunt-cli
RUN bower --allow-root install
RUN grunt

CMD ["node", "app.js"]
