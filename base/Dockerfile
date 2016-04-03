FROM python:3-alpine

RUN apk add --update alpine-sdk \
                     libxml2-dev \
                     libxslt-dev

# install doc2dash
RUN pip install doc2dash

RUN mkdir /docsets &&\
    mkdir /build
