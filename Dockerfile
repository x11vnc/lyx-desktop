# Builds a Docker image with Ubuntu 18.04 and LyX and some graphics tools
# and additional software recommended by https://wiki.lyx.org/LyX/LyXOnUbuntu
#
# Authors:
# Xiangmin Jiao <xmjiao@gmail.com>

FROM ams595/desktop:next
LABEL maintainer "Xiangmin Jiao <xmjiao@gmail.com>"

USER root
WORKDIR /tmp
COPY image/config $DOCKER_HOME/.config
COPY image/bin /usr/local/bin
COPY image/share /usr/share
COPY image/etc /etc
COPY image/home $DOCKER_HOME

# Install texlive and lyx
RUN add-apt-repository ppa:lyx-devel/release && \
    sh -c "curl -s http://dl.openfoam.org/gpg.key | apt-key add -" && \
    add-apt-repository http://dl.openfoam.org/ubuntu && \
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
        libxml2-dev \
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
        evince \
	dbus-x11 \
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
        xfig \
        cups cups-client \
        printer-driver-all \
        openprinting-ppds \
        system-config-printer \
        paraviewopenfoam56 \
        ffmpeg winff \
        libeigen3-dev && \
    apt-get clean && \
    curl -O http://bluegriffon.org/freshmeat/3.0.1/bluegriffon-3.0.1.Ubuntu16.04-x86_64.deb && \
    dpkg -i bluegriffon-3.0.1.Ubuntu16.04-x86_64.deb && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    chown -R $DOCKER_USER:$DOCKER_USER $DOCKER_HOME && \
    pip3 install \
        numpy \
        scipy \
        numba \
        numpydoc \
        setuptools \
        python-igraph \
        networkx \
        meshio \
        Cython \
        mpi4py \
        pytest \
        Sphinx \
        sphinx_rtd_theme && \
    mv /etc/ImageMagick-6/policy.xml /etc/ImageMagick-6/policy.xml_old

USER $DOCKER_USER
RUN echo '@lyx' >> $DOCKER_HOME/.config/lxsession/LXDE/autostart && \
    mkdir -p ~/.lyx && \
    ln -s -f $DOCKER_HOME/.config/LyX/preferences ~/.lyx

USER root

WORKDIR $DOCKER_HOME
