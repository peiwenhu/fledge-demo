# on host machine outside docker, run:
# RUN curl -JLO "https://dl.filippo.io/mkcert/latest?for=linux/amd64"
# RUN chmod +x mkcert-v*-linux-amd64
# RUN cp mkcert-v*-linux-amd64 /usr/local/bin/mkcert
# RUN mkcert -install
# WORKDIR /tmp/certs
# RUN mkcert localhost
FROM debian:bullseye-slim
RUN apt update
RUN apt install -y net-tools curl git gnupg2 ca-certificates lsb-release debian-archive-keyring nginx default-jre default-jdk

RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && apt-get install -y nodejs
RUN npm install -g firebase-tools

# RUN curl -JLO "https://dl.filippo.io/mkcert/latest?for=linux/amd64"
# RUN chmod +x mkcert-v*-linux-amd64
# RUN cp mkcert-v*-linux-amd64 /usr/local/bin/mkcert
# ENV CAROOT="/demo/mkcert"
# RUN mkcert -install
# WORKDIR /demo/certs
# RUN mkcert localhost

COPY ./ /demo/fledge-demo/
WORKDIR /demo/fledge-demo
RUN npm install
WORKDIR /demo/fledge-demo/functions
RUN npm install --save firebase-admin

COPY nginx.conf /etc/nginx/nginx.conf

WORKDIR /demo/fledge-demo
RUN chmod 700 dockerentrypoint
CMD ["./dockerentrypoint"]

# on the browser, turn on privacy sandbox ads api
# chrome://flags/#privacy-sandbox-ads-apis
# turn on privacy sandbox in chrome://settings
#
# docker build  -t fledge-demo .
# interactive:
# docker stop demo;docker rm demo;docker run -it --volume "/tmp/certs":"/demo/certs" -p 8080:8080 -p 8085:8085 -p 8086:8086 -p 8087:8087 -p 8088:8088 -p 4437:4437 -p 4438:4438 --name demo fledge-demo
#
#
# below doesn't work yet
# standard run:
# docker run --volume "../mkcert":"/demo/mkcert" -p 8080:8080 -p 8085:8085 -p 8086:8086 -p 8087:8087 -p 8088:8088 -p 4437:4437 -p 4438:4438 --name demo fledge-demo
#
# to clean up:
# docker stop demo;docker rm demo
