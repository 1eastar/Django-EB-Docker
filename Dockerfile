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

WORKDIR     /home/ubuntu/django-sample-for-docker-compose

RUN         cp -f /home/ubuntu/django-sample-for-docker-compose/.config/nginx.conf           /etc/nginx
RUN         cp -f /home/ubuntu/django-sample-for-docker-compose/.config/djangobackend      /etc/nginx/sites-available

RUN         rm -f /etc/nginx/sites-enabled/*
RUN         ln -fs /etc/nginx/sites-available/djangobackend                  /etc/nginx/sites-enabled

RUN         cp -f /home/ubuntu/django-sample-for-docker-compose/.config/supervisor_app.conf  /etc/supervisor/conf.d

EXPOSE      8000

CMD         supervisord -n
