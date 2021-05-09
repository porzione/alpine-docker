# vi: ft=dockerfile
FROM alpine:3.13.5

RUN apk add --no-cache \
    bash \
    coreutils \
    curl \
    drill \
    jq \
    netcat-openbsd \
    nmap \
    procps \
    rsync \
    sed \
    socat \
    tcpdump \
    wget \
    && true

# https://github.com/sgerrand/alpine-pkg-glibc
RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.33-r0/glibc-2.33-r0.apk && \
    apk add glibc-2.33-r0.apk && \
    rm glibc-2.33-r0.apk

RUN mkdir -m777 -p /mnt/data /mnt/tmp /mnt/pvc
    
ADD daemon.sh /
ENTRYPOINT ["/daemon.sh"]

ARG SOURCE_BRANCH=""
ARG SOURCE_COMMIT=""
RUN echo $(date +'%y%m%d_%H%M%S_%Z') ${SOURCE_BRANCH} ${SOURCE_COMMIT} > /build.txt
#SHELL ["/bin/bash", "-c"]
#RUN echo "PATH=$PATH" > /etc/environment
