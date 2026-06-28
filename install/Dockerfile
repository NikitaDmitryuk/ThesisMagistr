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
        poppler-utils \
        fontconfig \
        ttf-mscorefonts-installer && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN cd /tmp && \
    wget -q -O XITSMath-Regular.otf https://github.com/khaledhosny/xits-math/raw/master/XITSMath-Regular.otf && \
    wget -q -O PTSansOFL.zip https://ponce.cc/slackware/sources/repo/ttf-paratype-pt-fonts/PTSansOFL.zip && \
    wget -q -O PTMonoOFL.zip https://ponce.cc/slackware/sources/repo/ttf-paratype-pt-fonts/PTMonoOFL.zip && \
    printf '%s\n' \
        '3025792adb0b7072ace08bf5726d341de32f2254612ddec6dd98271a8dd29689  XITSMath-Regular.otf' \
        '57448741b709c5f022127134ffd49506e3925242bd06f73a039e070765d1d637  PTSansOFL.zip' \
        'e34e729f9509cf85acc52caadf68e96db90457b7164ba45719967d53e7a20dcc  PTMonoOFL.zip' | sha256sum -c - && \
    mv XITSMath-Regular.otf /usr/share/fonts/xits-math.otf && \
    unzip -q -o PTSansOFL.zip -d /usr/share/fonts/ && \
    unzip -q -o PTMonoOFL.zip -d /usr/share/fonts/ && \
    rm -f PTSansOFL.zip PTMonoOFL.zip && \
    fc-cache -f -v

RUN cd /tmp && \
    wget -q -O tex-pscyr_0.4d~beta9-1_all.deb https://people.debian.org/~sgolovan/debian/pool/main/tex/tex-pscyr/tex-pscyr_0.4d~beta9-1_all.deb && \
    printf '%s\n' \
        '2936ef0c4a618a73ae72192f53bc98cd2096c231e2fa9db37c479822214b842d  tex-pscyr_0.4d~beta9-1_all.deb' | sha256sum -c - && \
    dpkg -i tex-pscyr_0.4d~beta9-1_all.deb && \
    rm -f tex-pscyr_0.4d~beta9-1_all.deb

# TeX Live 2025 ships GOST .bst files with a trailing \endinput that BibTeX treats as a command.
RUN mktexlsr && \
    GOST_STYLE="$(kpsewhich gost2008.bst)" && \
    test -n "$GOST_STYLE" && \
    sed -i 's/^\\endinput$/%% \\endinput/' "$GOST_STYLE" && \
    ! grep -qx '\\endinput' "$GOST_STYLE" && \
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
