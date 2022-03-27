FROM python:3.10.4-slim-bullseye

# python web and database library install
ENV PYTHONUNBUFFERED 1
RUN mkdir /code
WORKDIR /code
RUN groupadd -g 1001 user;\
    useradd -u 1001 -g user user
COPY requirements.txt /code/
RUN set -eux; \
    devAptMark="$(apt-mark showmanual)"; \
    apt update; \
    apt install -y build-essential libmariadb-dev; \
    pip install -U pip setuptools; \
    pip install -r requirements.txt; \
    ldconfig; \
    apt-mark auto '.*' > /dev/null; \
    apt-mark manual $devAptMark; \
    find /usr/local -type f -executable -not \( -name '*tkinter*' \) -exec ldd '{}' ';' \
        | awk '/=>/ { print $(NF-1) }' \
        | sort -u \
        | xargs -r dpkg-query --search \
        | cut -d: -f1 \
        | sort -u \
        | xargs -r apt-mark manual \
    ; \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
    rm -rf /var/lib/apt/lists/*; \
    apt update; apt install -y wget
# nodejs
RUN set -eux; \
    apt update; apt install -y nodejs npm git sudo; \
    npm install -g n; \
    n stable; \
    apt purge -y --auto-remove nodejs npm
    #npm install -g typescript
RUN npm install -g ts-node typescript sass; \
    npm install -g bootstrap

# usermod for www-data & sudo group
RUN usermod -d /code www-data; \
    usermod -s /bin/bash www-data; \
    echo "%www-data ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/www-data
    #adduser www-data sudo

RUN echo '#!/bin/bash' > /code/startup; \
    echo 'echo startup script.' >> /code/startup; \
    chmod +x /code/startup

CMD ["/code/startup"]
