# syntax=docker/dockerfile:1.0.0-experimental

FROM python:3.7

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
    libpq-dev \
    libjpeg-dev \
    zlib1g-dev \
    software-properties-common \
    geoip-bin

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash \ 
  && apt-get install nodejs -y

RUN node -v
RUN npm -v

RUN mkdir -p -m 0600 ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts

RUN mkdir -p /code/siwebapp
WORKDIR /code

COPY ./webapp/ /code/

RUN pip install -r requirements.txt
RUN --mount=type=ssh pip install -r si_requirements.txt

WORKDIR /code/siwebapp
RUN npm config set strict-ssl false
RUN npm install -g bower grunt-cli
RUN --mount=type=ssh npm install 
RUN --mount=type=ssh bower install --allow-root
RUN grunt coffee
WORKDIR /code

COPY si-web-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/si-web-entrypoint.sh
RUN ln -s /usr/local/bin/si-web-entrypoint.sh .

ENTRYPOINT ["si-web-entrypoint.sh"]
