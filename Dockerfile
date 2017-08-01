# Builds a Docker image with Ubuntu 16.04 and LyX and some graphics tools
# and additional software recommended by https://wiki.lyx.org/LyX/LyXOnUbuntu
#
# Authors:
# Xiangmin Jiao <xmjiao@gmail.com>

FROM x11vnc/desktop:latest
LABEL maintainer "Xiangmin Jiao <xmjiao@gmail.com>"

USER root
WORKDIR /tmp
COPY image/LyX $DOCKER_HOME/.config

# Install texlive and lyx
RUN add-apt-repository ppa:lyx-devel/release && \
    apt-get update && \
    apt-get install -q -y --no-install-recommends \
        texlive \
        texlive-lang-english \
        texlive-generic-recommended \
        texlive-latex-recommended \
        texlive-fonts-recommended \
        texlive-extra-utils \
        texlive-fonts-extra \
        texlive-formats-extra \
        texlive-generic-extra \
        texlive-latex-extra \
        texlive-math-extra \
        texlive-science \
        \
        python-lxml \
        \
        preview-latex-style \
        dvipng \
        lyx \
        jabref \
        imagemagick \
        hunspell \
        aspell \
        aspell-en \
        ispell \
        evince \
        xpdf \
        psutils \
        pstoedit \
        ps2eps \
        gv \
        latex2rtf \
        latex2html \
        chktex \
        \
        inkscape \
        tgif \
        xfig && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    chown -R $DOCKER_USER:$DOCKER_USER $DOCKER_HOME/.config

USER $DOCKER_USER
RUN echo '@lyx' >> $DOCKER_HOME/.config/lxsession/LXDE/autostart && \
    mkdir -p ~/.lyx && \
    ln -s -f $DOCKER_HOME/.config/LyX/preferences ~/.lyx

USER root

WORKDIR $DOCKER_HOME
