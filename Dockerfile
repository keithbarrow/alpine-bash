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
    python \
    py-pip && \
    pip install awscli &&\
    curl https://sdk.cloud.google.com | bash /
    /root/google-cloud-sdk/bin/gcloud components install beta
