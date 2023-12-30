FROM php:7.2-apache

RUN apt-get update
RUN apt-get install -y python3 python3-pip libapache2-mod-wsgi-py3

COPY requirements.txt .
COPY 000-default.conf /etc/apache2/sites-enabled/000-default.conf

RUN pip3 install -r requirements.txt
RUN rm requirements.txt

RUN groupadd -r tsakorpus
RUN useradd --no-log-init -r -g tsakorpus tsakorpus

