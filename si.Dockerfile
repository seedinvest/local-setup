# syntax=docker/dockerfile:1.0.0-experimental

FROM python:2.7

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
    libpq-dev \
    libjpeg-dev \
    zlib1g-dev \
    libmagickwand-dev \
    software-properties-common \
    geoip-bin \
    postgresql-client 

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash \ 
  && apt-get install nodejs -y

RUN node -v
RUN npm -v

RUN mkdir -p -m 0600 ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts

RUN mkdir /code
WORKDIR /code

RUN mkdir fieldkeys
RUN pip install python-keyczar
RUN keyczart create --location=fieldkeys --purpose=crypt
RUN keyczart addkey --location=fieldkeys --status=primary

COPY seedinvest/requirements.txt /code/
COPY seedinvest/si_requirements.txt /code/
COPY seedinvest/package.json /code/

RUN npm config set strict-ssl false
RUN --mount=type=ssh  npm install 

RUN pip install -r requirements.txt
RUN --mount=type=ssh pip install -r si_requirements.txt

ADD ./seedinvest/ /code/

COPY si-services-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/si-services-entrypoint.sh
RUN ln -s /usr/local/bin/si-services-entrypoint.sh .

ENTRYPOINT ["si-services-entrypoint.sh"]
