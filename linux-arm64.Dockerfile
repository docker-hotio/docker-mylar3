FROM hotio/base@sha256:dfa66c21a6b019329679000bd0353b7547f7702c1c38fdeb03c75740bc8c10f4
EXPOSE 8090

RUN apk add --no-cache nodejs python3 py3-openssl py3-setuptools py3-six py3-openssl py3-requests py3-urllib3 libjpeg-turbo unrar && \
    apk add --no-cache --virtual=build-dependencies py3-pip gcc zlib-dev libjpeg-turbo-dev python3-dev musl-dev make g++ && \
    pip3 install --no-cache-dir --upgrade \
        APScheduler>=3.6.3 \
        beautifulsoup4>=4.8.2 \
        cfscrape>=2.0.8 \
        cheroot==8.2.1 \
        CherryPy>=18.5.0 \
        configparser>=4.0.2 \
        feedparser>=5.2.1 \
        Mako>=1.1.0 \
        natsort>=3.5.2 \
        Pillow>=4.2.1,~=6.2.2 \
        portend>=2.6 \
        pytz>=2019.3 \
        simplejson>=3.17.0 \
        tzlocal>=2.0.0 \
        unrar>=0.3 \
        unrar-cffi==0.1.0a5 && \
    apk del --purge build-dependencies

ARG VERSION
RUN curl -fsSL "https://github.com/mylar3/mylar3/archive/${VERSION}.tar.gz" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
