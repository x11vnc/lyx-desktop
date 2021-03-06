# Builds a Docker image with Ubuntu 20.04 and LyX and some graphics tools
# and additional software recommended by https://wiki.lyx.org/LyX/LyXOnUbuntu
#
# Authors:
# Xiangmin Jiao <xmjiao@gmail.com>

FROM x11vnc/desktop:latest
LABEL maintainer "Xiangmin Jiao <xmjiao@gmail.com>"

USER root
WORKDIR /tmp
COPY image/config $DOCKER_HOME/.config
COPY image/etc /etc
COPY image/bin /usr/local/bin

# Install texlive and lyx
RUN add-apt-repository ppa:lyx-devel/release && \
    apt-get update && \
    echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections && \
    apt-get install -q -y --no-install-recommends \
        texlive \
        texlive-lang-english \
        texlive-generic-recommended \
        texlive-latex-recommended \
        texlive-fonts-recommended \
        texlive-extra-utils \
        texlive-font-utils \
        texlive-formats-extra \
        texlive-generic-extra \
        texlive-latex-extra \
        texlive-bibtex-extra \
        texlive-publishers \
        texlive-pstricks \
        texlive-science \
        lmodern \
        \
        libtool m4 automake \
        python-lxml \
        \
        preview-latex-style \
        dvipng \
        texmaker \
        lyx \
        fonts-lyx \
        msttcorefonts \
        jabref \
        imagemagick \
        hunspell \
        hunspell-en-us \
        aspell \
        aspell-en \
        ispell \
	dbus-x11 \
        evince \
        xpdf \
	at-spi2-core \
        psutils \
        pstoedit \
        ps2eps \
        gv \
        latex2rtf \
        latex2html \
        libreoffice \
        chktex \
        pandoc \
        \
        pinta \
        inkscape \
        tgif \
        xfig && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    chown -R $DOCKER_USER:$DOCKER_USER $DOCKER_HOME/.config && \
    mv /etc/ImageMagick-6/policy.xml /etc/ImageMagick-6/policy.xml_old

USER $DOCKER_USER
RUN echo '@lyx' >> $DOCKER_HOME/.config/lxsession/LXDE/autostart && \
    mkdir -p ~/.lyx && \
    ln -s -f $DOCKER_HOME/.config/LyX/preferences ~/.lyx

USER root

WORKDIR $DOCKER_HOME
