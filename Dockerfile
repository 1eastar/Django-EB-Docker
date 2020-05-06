FROM python:3

RUN         apt -y update && apt -y dist-upgrade
RUN         apt -y install build-essential
RUN         apt -y install libpcre3 libpcre3-dev python-dev
RUN apt-get update && apt-get -y install \
    libpq-dev

WORKDIR /app
ADD    ./requirements.txt   /app/
RUN    pip install -r requirements.txt

ADD    ./djangosample   /app/djangosample/
ADD    ./manage.py      /app/

CMD ["python", "manage.py", "runserver", "0:8000"]
