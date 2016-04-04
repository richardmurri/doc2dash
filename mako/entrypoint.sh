#!/bin/sh

NAME=Mako
REVISION=${2-"master"}

build () {
    if [ -d "/docsets/${NAME}.docset" ]; then
        echo "Docset ${NAME}.docset already exists. Cowardly fail!!!"
        return 1
    fi

    cd /build
    wget "https://bitbucket.org/zzzeek/mako/get/$REVISION.tar.gz" -O mako.tar.gz || return 1
    tar -xf mako.tar.gz || return 1
    cd zzzeek* || return 1

    python setup.py install || return 1

    cd doc/build
    make html
    #python setup.py build_sphinx || return 1

    doc2dash -n "$NAME" -I index.html -u https://bitbucket.org/zzzeek/mako `pwd`/output/html || return 1
    cp -r "${NAME}.docset" "/docsets/${NAME}.docset"
}

case "$1" in
    "build" ) build;;
    * ) exec "$@";;  # run command line args passed in
esac
