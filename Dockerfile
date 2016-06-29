FROM alpine:latest
MAINTAINER daniel@ngineered.co.uk

RUN apk --no-cache add \

openssl \
ca-certificates \
bash \
vim \ 
curl \
netcat-openbsd \
perl-net-telnet \
grep \
openssh-client \
nmap \
