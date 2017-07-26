# Builds a Docker image with Ubuntu 16.04 and LyX and some graphics tools
# and additional software recommended by https://www.lyx.org/AdditionalSoftware
#
# Authors:
# Xiangmin Jiao <xmjiao@gmail.com>

FROM x11vnc/desktop:latest
LABEL maintainer "Xiangmin Jiao <xmjiao@gmail.com>"

USER root
WORKDIR /tmp

# Install texlive and lyx
RUN add-apt-repository ppa:webupd8team/atom && \
    add-apt-repository ppa:lyx-devel/release && \
    apt-get update && \
    apt-get install -q -y --no-install-recommends \
        texlive \
        python-lxml \
        pstoedit \
        atom \
        lyx \
        jabref \
        imagemagick \
        hunspell \
        aspell \
        evince \
        xpdf \
        gv \
        latex2rtf \
        latex2html \
        ps2eps \
        chktex \
        \
        inkscape \
        tgif \
        xfig \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER $DOCKER_USER
RUN echo '@lyx' >> $DOCKER_HOME/.config/lxsession/LXDE/autostart

USER root

WORKDIR $DOCKER_HOME
