FROM node:6.10

EXPOSE 3000
EXPOSE 3001
VOLUME /mnt/ledger

RUN apt-get update && \
    apt-get install -y ledger && \
    apt-get clean -y && \
    apt-get autoclean -y && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt-lists/*

RUN git clone --depth 1 https://github.com/slashdotdash/node-ledger-web

WORKDIR node-ledger-web

RUN npm install
RUN npm install --global bower grunt-cli
RUN bower --allow-root install
RUN grunt

COPY config.json .

CMD node app.js
