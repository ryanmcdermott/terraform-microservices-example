FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y vim
RUN apt-get install -y python3-pip
RUN apt-get install -y nginx supervisor
RUN apt-get install -y libpq-dev
RUN apt-get install -y postgresql
RUN apt-get install -y tmux
RUN pip3 install uwsgi
RUN pip3 install Flask
RUN pip3 install flask-restful
RUN pip3 install SQLAlchemy
RUN pip3 install psycopg2
RUN pip3 install alembic
RUN pip3 install pyyaml
RUN pip3 install watchdog
RUN pip3 install argh

ADD ./src /usr/local/api

RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
RUN rm /etc/nginx/sites-enabled/default

EXPOSE 8080

WORKDIR /usr/local/api
ENTRYPOINT watchmedo auto-restart --recursive --pattern="*.py" --directory="." /bin/bash /usr/local/api/start.sh
