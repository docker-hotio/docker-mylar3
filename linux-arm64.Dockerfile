FROM hotio/base@sha256:300224ec3423d5e2f3e44f4938a9eba57912ffac933906c005cae744b4095b30

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 8090

# install packages
RUN apt update && \
    apt install -y --no-install-recommends --no-install-suggests \
        nodejs python3-pkg-resources libjpeg8 \
        python3-pip python3-setuptools build-essential python3-all-dev libffi-dev libjpeg-dev libssl-dev && \
    pip3 install --no-cache-dir --upgrade \
        pyopenssl \
        APScheduler>=3.6.3 beautifulsoup4>=4.8.2 cfscrape>=2.0.8 cheroot==8.2.1 CherryPy>=18.5.0 configparser>=4.0.2 feedparser>=5.2.1 Mako>=1.1.0 natsort>=3.5.2 Pillow>=4.2.1,~=6.2.2 portend>=2.6 pytz>=2019.3 requests>=2.22.0 simplejson>=3.17.0 six>=1.13.0 tzlocal>=2.0.0 unrar>=0.3 unrar-cffi==0.1.0a5 urllib3>=1.25.7 && \
# clean up
    apt purge -y python3-pip python3-setuptools build-essential python3-all-dev libffi-dev libjpeg-dev libssl-dev && \
    apt autoremove -y && \
    apt clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

ARG MYLAR3_VERSION=cfc4885b32c80ce2f374d452ca95e4353ef0fc4a

# install app
RUN curl -fsSL "https://github.com/mylar3/mylar3/archive/${MYLAR3_VERSION}.tar.gz" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
