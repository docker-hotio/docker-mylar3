FROM hotio/base@sha256:281b575c3b949a82a9314388e206fccf6fbff19ba55f0238cec0b13a31226c62

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 8090

ARG MYLAR3_VERSION=e1c3f4a7a221f61eca7a6086f47864dc29dad4d2

# install app
RUN curl -fsSL "https://github.com/mylar3/mylar3/archive/${MYLAR3_VERSION}.tar.gz" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

# install packages
RUN apt update && \
    apt install -y --no-install-recommends --no-install-suggests \
        nodejs python3-pkg-resources \
        python3-pip python3-setuptools && \
    pip3 install --no-cache-dir --upgrade -r "${APP_DIR}/requirements.txt" && \
# clean up
    apt purge -y python3-pip python3-setuptools && \
    apt autoremove -y && \
    apt clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

COPY root/ /
