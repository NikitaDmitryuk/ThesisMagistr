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

# RUN wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
# RUN tar xvzf $(ls install-tl-*.tar.gz)
# RUN cd $(ls -d install-tl-*/) && echo I | ./install-tl

RUN apt install -y biber \
	 latexmk

RUN apt install -y texlive-base \
        texlive-latex-extra \
        texlive-xetex \
        texlive-lang-cyrillic \
        texlive-lang-greek \
        texlive-fonts-extra \
        texlive-science \
        texlive-latex-recommended \
	texlive-bibtex-extra

# Times New Roman and other fonts
RUN apt install -y fontconfig
RUN apt install -y --reinstall ttf-mscorefonts-installer && \
    wget -O /usr/share/fonts/xits-math.otf https://github.com/khaledhosny/xits-math/raw/master/XITSMath-Regular.otf && \
    wget https://ftp.tw.freebsd.org/distfiles/xorg/font/PTSansOFL.zip && \
    wget https://ftp.tw.freebsd.org/distfiles/xorg/font/PTMonoOFL.zip && \
    unzip -o PTSansOFL.zip -d /usr/share/fonts/ && unzip -o PTMonoOFL.zip -d /usr/share/fonts/ && \
    rm -f PTSansOFL.zip PTMonoOFL.zip && \
    fc-cache -f -v

RUN apt install -y texlive-luatex
# RUN update-language


VOLUME $DIR
WORKDIR $DIR
