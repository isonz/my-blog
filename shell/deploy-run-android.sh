#!/bin/bash

tar zxvf /app/mobile/package.tgz -C /app/mobile/code

cd /app/mobile/code

flutter build apk --release --flavor prod --target lib/main_prod.dart

cp -f /app/mobile/code/build/app/outputs/apk/prod/release/app-prod-release.apk /app/apk/gigi.apk
cp -f /app/mobile/code/build/app/outputs/apk/prod/release/output-metadata.json /app/apk/

