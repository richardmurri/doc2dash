#!/bin/sh

NAME=MonthDelta
REVISION=${2-"master"}

build () {
    if [ -d "/docsets/${NAME}.docset" ]; then
        echo "Docset ${NAME}.docset already exists. Cowardly fail!!!"
        return 1
    fi

    cd /build
    wget "https://github.com/jessaustin/monthdelta/archive/$REVISION.tar.gz" -O monthdelta.tar.gz || return 1
    tar -xf monthdelta.tar.gz || return 1
    cd monthdelta* || return 1

    sed -i 's/distutils2.core/setuptools/' setup.py

    python setup.py install || return 1
    python setup.py build_sphinx || return 1

    doc2dash -n "$NAME" -I index.html -u https://github.com/jessaustin/monthdelta `pwd`/doc/build/html || return 1
    cp -r "${NAME}.docset" "/docsets/${NAME}.docset"
}

case "$1" in
    "build" ) build;;
    * ) exec "$@";;  # run command line args passed in
esac
