#!/bin/sh
if [ -z ${DJANGO_NAME} ]; then
    exit 1;
fi
ln -s /code/${DJANGO_NAME}/static /static
