FROM ubuntu:24.04
LABEL maintainer="NikitaDmitryuk dmitryuk.nikita@gmail.com"
LABEL org.opencontainers.image.description="https://github.com/NikitaDmitryuk/ThesisMagistr"

ENV DEBIAN_FRONTEND=noninteractive \
    DEBCONF_NONINTERACTIVE_SEEN=true \
    DIR=/diplom \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

RUN mkdir -p $DIR

RUN echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        wget \
        git \
        make \
        ca-certificates \
        unzip \
        texlive-full \
        biber \
        latexmk \
        fontconfig \
        ttf-mscorefonts-installer && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN cd /tmp && \
    wget -q -O /usr/share/fonts/xits-math.otf https://github.com/khaledhosny/xits-math/raw/master/XITSMath-Regular.otf && \
    wget -q https://ponce.cc/slackware/sources/repo/ttf-paratype-pt-fonts/PTSansOFL.zip && \
    wget -q https://ponce.cc/slackware/sources/repo/ttf-paratype-pt-fonts/PTMonoOFL.zip && \
    unzip -q -o PTSansOFL.zip -d /usr/share/fonts/ && \
    unzip -q -o PTMonoOFL.zip -d /usr/share/fonts/ && \
    rm -f PTSansOFL.zip PTMonoOFL.zip && \
    fc-cache -f -v

RUN cd /tmp && \
    wget -q https://people.debian.org/~sgolovan/debian/pool/main/tex/tex-pscyr/tex-pscyr_0.4d~beta9-1_all.deb && \
    dpkg -i tex-pscyr_0.4d~beta9-1_all.deb && \
    rm -f tex-pscyr_0.4d~beta9-1_all.deb

VOLUME $DIR
WORKDIR $DIR
