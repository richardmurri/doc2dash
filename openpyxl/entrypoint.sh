#!/bin/sh

NAME=Openpyxl
REVISION=${2-"tip"}

build () {
    if [ -d "/docsets/${NAME}.docset" ]; then
        echo "Docset ${NAME}.docset already exists. Cowardly fail!!!"
        return 1
    fi

    cd /build
    wget "https://bitbucket.org/openpyxl/openpyxl/get/$REVISION.tar.gz" -O openpyxl.tar.gz || return 1
    tar -xf openpyxl.tar.gz || return 1
    cd openpyxl* || return 1

    python setup.py install || return 1
    python setup.py build_sphinx || return 1

    doc2dash -n "$NAME" -I index.html -u https://bitbucket.org/openpyxl/openpyxl `pwd`/build/sphinx/html || return 1
    cp -r "${NAME}.docset" "/docsets/${NAME}.docset"
}

case "$1" in
    "build" ) build;;
    * ) exec "$@";;  # run command line args passed in
esac
