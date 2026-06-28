FROM ubuntu:26.04
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

# TeX Live 2025 ships GOST .bst files with a trailing \endinput that BibTeX treats as a command.
RUN mktexlsr && \
    sed -i 's/^\\endinput$/%% \\endinput/' "$(kpsewhich gost2008.bst)" && \
    updmap-sys && \
    printf '%s\n' \
        '\documentclass{article}' \
        '\usepackage[T2A]{fontenc}' \
        '\usepackage[utf8]{inputenc}' \
        '\usepackage[english,russian]{babel}' \
        '\renewcommand{\rmdefault}{ftm}' \
        '\newcommand{\warm}[1]{{\fontsize{#1}{#1}\selectfont Прогрев кириллических шрифтов: обычный, \textbf{жирный}, \textit{курсив}. {\sffamily Обычный sans, \textbf{жирный sans}, \textit{курсив sans}.}\par}}' \
        '\begin{document}' \
        '\warm{5}\warm{6}\warm{7}\warm{8}\warm{9}\warm{10}\warm{10.95}\warm{12}\warm{14.4}\warm{17.28}\warm{24.88}' \
        '\end{document}' > /tmp/font-warmup.tex && \
    pdflatex -interaction=nonstopmode -halt-on-error /tmp/font-warmup.tex >/tmp/font-warmup.log && \
    for font in \
        larm0500 larm0600 larm0700 larm0800 larm0900 larm1000 \
        larm1095 larm1200 larm1440 larm1728 larm2074 larm2488; do \
        mktextfm "$font" >/dev/null; \
    done && \
    mktexlsr /root/.texlive2025/texmf-var && \
    rm -f /tmp/font-warmup.*

VOLUME $DIR
WORKDIR $DIR
