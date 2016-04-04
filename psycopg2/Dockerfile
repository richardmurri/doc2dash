FROM rmurri/doc2dash

RUN apk add --update libpq \
                     postgresql-dev &&\
    pip install virtualenv

COPY entrypoint.sh /entrypoint
ENTRYPOINT ["/bin/sh", "/entrypoint"]
