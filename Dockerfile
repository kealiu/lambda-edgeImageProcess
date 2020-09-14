FROM amazonlinux:latest

WORKDIR /tmp
#install the dependencies
RUN yum -y install gcc-c++ && yum -y install findutils tar gzip

RUN touch ~/.bashrc && chmod +x ~/.bashrc

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

RUN source ~/.bashrc && nvm install 12.18 

WORKDIR /build
