FROM ubuntu:24.04
LABEL maintainer="NikitaDmitryuk dmitryuk.nikita@gmail.com"
LABEL org.opencontainers.image.description="https://github.com/NikitaDmitryuk/ThesisMagistr"

ENV DEBIAN_FRONTEND=noninteractive \
    DEBCONF_NONINTERACTIVE_SEEN=true \
    DIR=/diplom

# Create the working directory
RUN mkdir $DIR

# Configure debconf for ttf-mscorefonts-installer
RUN echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections

# Update package index and install necessary packages
RUN apt update && \
    apt install -y wget \
        git \
        make \
        apt-transport-https \
        unzip \
        texlive-full \
        biber \
        latexmk \
        fontconfig \
        ttf-mscorefonts-installer && \
    rm -rf /var/lib/apt/lists/*

# Download additional fonts
RUN wget -O /usr/share/fonts/xits-math.otf https://github.com/khaledhosny/xits-math/raw/master/XITSMath-Regular.otf && \
    wget https://ponce.cc/slackware/sources/repo/ttf-paratype-pt-fonts/PTSansOFL.zip && \
    wget https://ponce.cc/slackware/sources/repo/ttf-paratype-pt-fonts/PTMonoOFL.zip && \
    unzip -o PTSansOFL.zip -d /usr/share/fonts/ && \
    unzip -o PTMonoOFL.zip -d /usr/share/fonts/ && \
    rm -f PTSansOFL.zip PTMonoOFL.zip && \
    fc-cache -f -v

# Install tex-pscyr package
RUN wget https://people.debian.org/~sgolovan/debian/pool/main/tex/tex-pscyr/tex-pscyr_0.4d~beta9-1_all.deb && \
    dpkg -i tex-pscyr_0.4d~beta9-1_all.deb && \
    rm tex-pscyr_0.4d~beta9-1_all.deb

VOLUME $DIR
WORKDIR $DIR
