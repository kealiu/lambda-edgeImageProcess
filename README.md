# Build


Detail Reference: https://kealiu.github.io/Resize-Image-On-The-Fly-Using-Lambda-at-Edge-and-Cloudfront-With-S3/

- chagne the bucket name in source code
- build and upload to AWS

```

# install docker
sudo apt install docker.io

# build nodejs docker package env
sudo docker build --tag amazonlinux:nodejs .

# init package env
sudo docker run --rm --volume ${PWD}/lambda/origin-response-function:/build amazonlinux:nodejs /bin/bash -c "source ~/.bashrc; npm init -f -y; npm install sharp --save; npm install querystring --save; npm install --only=prod"
sudo docker run --rm --volume ${PWD}/lambda/viewer-request-function:/build amazonlinux:nodejs /bin/bash -c "source ~/.bashrc; npm init -f -y; npm install querystring --save; npm install --only=prod"

# build zip package
rm dist/*.zip
mkdir -p dist && cd lambda/origin-response-function && zip -FS -q -r ../../dist/origin-response-function.zip * && cd ../..
mkdir -p dist && cd lambda/viewer-request-function && zip -FS -q -r ../../dist/viewer-request-function.zip * && cd ../..

# upload to aws
aws --region us-east-1 lambda update-function-code --function-name function_name_for_rewrite_url --zip-file fileb://dist/viewer-request-function.zip
aws --region us-east-1 lambda update-function-code --function-name function_name_for_handle_response --zip-file fileb://dist/origin-response-function.zip
```
