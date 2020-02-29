FROM hotio/base@sha256:d24ffc9095a7b4cc0cce8e8d07e68955f4b06b649ff0d0324f545b747242969d

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 8090

ARG MYLAR3_VERSION=0.2.3

# install app
RUN curl -fsSL "https://github.com/mylar3/mylar3/archive/v${MYLAR3_VERSION}.tar.gz" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

# install packages
RUN apt update && \
    apt install -y --no-install-recommends --no-install-suggests \
        nodejs \
        python3-pip python3-setuptools && \
    pip3 install --no-cache-dir --upgrade -r "${APP_DIR}/requirements.txt" && \
# clean up
    apt purge -y python3-pip python3-setuptools && \
    apt autoremove -y && \
    apt clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

COPY root/ /
