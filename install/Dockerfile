# syntax=docker/dockerfile:1
FROM ubuntu:20.04
LABEL maintainer="NikitaDmitryuk dmitryuk.nikita@gmail.com"

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true
ENV DIR /diplom

RUN mkdir $DIR
RUN echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections
RUN apt update && \
    apt install -y wget \
        git \
        make \
        apt-transport-https \
        unzip

RUN apt install -y texlive-full

RUN apt install -y biber \
	 latexmk

# Times New Roman and other fonts
RUN apt install -y fontconfig
RUN apt install -y --reinstall ttf-mscorefonts-installer && \
    wget -O /usr/share/fonts/xits-math.otf https://github.com/khaledhosny/xits-math/raw/master/XITSMath-Regular.otf && \
    wget https://ftp.tw.freebsd.org/distfiles/xorg/font/PTSansOFL.zip && \
    wget https://ftp.tw.freebsd.org/distfiles/xorg/font/PTMonoOFL.zip && \
    unzip -o PTSansOFL.zip -d /usr/share/fonts/ && unzip -o PTMonoOFL.zip -d /usr/share/fonts/ && \
    rm -f PTSansOFL.zip PTMonoOFL.zip && \
    fc-cache -f -v

RUN wget https://people.debian.org/~sgolovan/debian/pool/main/tex/tex-pscyr/tex-pscyr_0.4d~beta9-1_all.deb
RUN dpkg -i tex-pscyr_0.4d~beta9-1_all.deb

VOLUME $DIR
WORKDIR $DIR
