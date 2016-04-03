#!/bin/sh

NAME=Colander
REVISION=${2-"master"}

build () {
    if [ -d "/docsets/${NAME}.docset" ]; then
        echo "Docset ${NAME}.docset already exists. Cowardly fail!!!"
        return 1
    fi

    cd /build
    wget "https://github.com/Pylons/colander/archive/$REVISION.tar.gz" -O colander.tar.gz || return 1
    tar -xf colander.tar.gz || return 1
    cd colander* || return 1

    python setup.py install || return 1
    python setup.py build_sphinx || return 1

    doc2dash -n "$NAME" -I index.html -u https://github.com/Pylons/colander `pwd`/build/sphinx/html || return 1
    cp -r "${NAME}.docset" "/docsets/${NAME}.docset"
}

case "$1" in
    "build" ) build;;
    * ) exec "$@";;  # run command line args passed in
esac
