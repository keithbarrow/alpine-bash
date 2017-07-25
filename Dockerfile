FROM alpine:latest
MAINTAINER support@ngineered.co.uk

ADD settings/bashrc /etc/bash.bashrc
ADD settings/bashrc /etc/skel/.bashrc
ADD settings/vimrc /etc/vim/vimrc
ADD settings/profile /etc/profile

RUN echo http://nl.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories && \
    echo http://nl.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories && \
    echo http://nl.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
    apk update && \
    apk --no-cache add \
    git \
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
    drill \
    python3 \
    openvpn \
    sudo && \
    pip3 install awscli &&\
    pip3 install boto3 &&\
    ln -s /usr/bin/drill /usr/bin/dig && \
    curl https://sdk.cloud.google.com | bash && \
    mv /root/google-cloud-sdk / && \
    /google-cloud-sdk/bin/gcloud components install beta && \
    /google-cloud-sdk/bin/gcloud components install kubectl

ADD settings/motd /etc/motd
# Set Root to bash not ash and overwrite .bashrc
RUN sed -i 's/root:\/bin\/ash/root:\/bin\/bash/' /etc/passwd && \
    cp /etc/skel/.bashrc /root/.bashrc

# Link vi to vim (otherwise ric no happy)
RUN ln -sf vim /usr/bin/vi

# Setup user

RUN /usr/sbin/adduser -D -G wheel -k /etc/skel -s /bin/bash user && \
    echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

USER user
WORKDIR /home/user

CMD ["/bin/bash"]
