#!/bin/sh

NAME=Psycopg2
REVISION=${2-"2.6.1"}

build () {
    if [ -d "/docsets/${NAME}.docset" ]; then
        echo "Docset ${NAME}.docset already exists. Cowardly fail!!!"
        return 1
    fi

    PYVER=$(python3 --version | sed 's/.* \(.*\)/\1/')
    PYLOC=$(which python)
    ln -s "$PYLOC" "$PYLOC$PYVER"

    cd /build
    wget "http://initd.org/psycopg/tarballs/PSYCOPG-2-6/psycopg2-${REVISION}.tar.gz" -O psycopg2.tar.gz || return 1
    tar -xf psycopg2.tar.gz || return 1
    cd psycopg2* || return 1

    python setup.py install || return 1
    cd doc || return 1
    make env || return 1
    make html || return 1

    doc2dash -n "$NAME" -I index.html -u http://initd.org/psycopg `pwd`/html || return 1
    cp -r "${NAME}.docset" "/docsets/${NAME}.docset"
}

case "$1" in
    "build" ) build;;
    * ) exec "$@";;  # run command line args passed in
esac
