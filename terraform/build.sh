#!/bin/bash

LAMBDA_LOCAL_PATH=$1

cd ../app
pipenv run pip freeze | xargs pip install --target ../package

cd ..
cp -R app/ package/

cd package
mv app/*.py .
zip -r9 ../$LAMBDA_LOCAL_PATH * -x *.zip -x '*/.*'

cd ..
rm -rf package