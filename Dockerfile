FROM python:2.7
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update && apt-get install -y \
        build-essential \
        gettext \
        nginx \
        supervisor \
    && rm -rf /var/lib/apt/lists/*

RUN easy_install pip

RUN pip install uwsgi

ENV APP_HOME=/home/docker/app
ENV SERVER_HOME=/home/docker/server

# setup all the configfiles
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# substitute env variable
COPY config /tmp/config
RUN  . /tmp/config/nginx_envsubst.sh

RUN  mv /tmp/nginx.conf /etc/nginx/sites-available/default
COPY config/supervisor.conf /etc/supervisor/conf.d/

COPY . ${SERVER_HOME}/

RUN rm -rf /tmp/*

EXPOSE 80
CMD ["supervisord", "-n"]
