FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
RUN apt update -y -qq && apt upgrade -y -qq
RUN apt install -y -qq --no-install-recommends \
    ca-certificates \
    curl \
    git \
    gnupg2 \
    npm \
    python-is-python3 \
    python3 \
    software-properties-common \
    xz-utils && npm i -g n && n latest

WORKDIR /root
ENV PATH=${PATH}:/root/depot_tools:/root/v8/tools/dev

RUN git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git --depth=1

RUN apt install sudo # TODO move
# snapcraft in docker and https://circleci.com/docs/2.0/high-uid-error/
# you can find it use `find / \! -uid 0 -print`
RUN fetch v8 && \
    cd v8 && \
    gclient sync && \
    sed -i 's/${dev_list} snapcraft/${dev_list}/g' build/install-build-deps.sh && \
    cd build && \
    ./install-build-deps.sh && \
    git reset HEAD --hard && \
    chown -R root:root /root/v8

COPY build /root
