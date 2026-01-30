#// Source - https://stackoverflow.com/a/72952418
#// Posted by Siddharth Choudhary
#// Retrieved 2026-01-28, License - CC BY-SA 4.0

#FROM debian:latest
FROM python:3.11-slim

ENV HTTPS_PROXY="http://ioc%5c00023569:321%402026Jan@mdproxy.ds.indianoil.in:8080"
ENV HTTP_PROXY="http://ioc%5c00023569:321%402026Jan@mdproxy.ds.indianoil.in:8080"
RUN export HTTPS_PROXY HTTP_PROXY


RUN  apt update
RUN  apt install -y ca-certificates curl
RUN  install -m 0755 -d /etc/apt/keyrings
#RUN  curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
#RUN  chmod a+r /etc/apt/keyrings/docker.asc

RUN set -ex \
    && mkdir -p /uploads /etc/apt/sources.list.d /var/cache/apt/archives/ \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get clean \
    && apt-get update -y \
    && apt-get install -y \
        bash \
        curl \
        openjdk-21-jre-headless \
        unzip \
        libhunspell-1.7-0 \
        hunspell-de-at


#        libhunspell-1.4-0 \
 
ENV VERSION=6.6
COPY LanguageTool-$VERSION.zip /LanguageTool-$VERSION.zip

RUN unzip LanguageTool-$VERSION.zip \
      && rm LanguageTool-$VERSION.zip
 
WORKDIR /LanguageTool-$VERSION

CMD ["java", "-cp", "languagetool-server.jar", "org.languagetool.server.HTTPServer", "--port", "8130", "--public", "--allow-origin", "'*'" ]
EXPOSE 8130



