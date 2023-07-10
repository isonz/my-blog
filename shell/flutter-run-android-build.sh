#!/bin/bash

#!/bin/bash

rm -rf /app/mobile/code
mkdir -p /app/mobile/code

tar zxvf /app/mobile/package.tgz -C /app/mobile/code


source /etc/profile

cd /app/mobile/code

flutter build apk --release --flavor dev --target lib/main.dart

cp -f /app/mobile/code/build/app/outputs/apk/dev/release/app-dev-release.apk /app/apk/gigi.apk
cp -f /app/mobile/code/build/app/outputs/apk/dev/release/output-metadata.json /app/apk/


