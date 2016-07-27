FROM nginx

ENV APP_HOME=/home/docker/app
ENV SERVER_HOME=/home/docker/server

# substitute env variable
COPY config/start_nginx.sh /
COPY . ${SERVER_HOME}/

CMD ["./start_nginx.sh"]
