FROM python:3

RUN         apt -y update && apt -y dist-upgrade
RUN         apt -y install build-essential
RUN         apt -y install nginx supervisor
RUN         apt -y install libpcre3 libpcre3-dev python-dev
RUN apt-get update && apt-get -y install \
    libpq-dev

WORKDIR /app
ADD    ./requirements.txt   /app/
RUN    pip install -r requirements.txt

ADD    ./djangosample   /app/djangosample/
ADD    ./manage.py      /app/

ENV         PROJECT_DIR              /home/ubuntu/django-sample-for-docker-compose

COPY        .                       ${PROJECT_DIR}

EXPOSE      80
