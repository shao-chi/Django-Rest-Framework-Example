FROM python:3.9

WORKDIR /api

ADD . /api

RUN apt-get -y update

RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt