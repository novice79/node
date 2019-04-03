FROM node:lts-slim
LABEL maintainer="David <david@cninone.com>"

# Get noninteractive frontend for Debian to avoid some problems:
#    debconf: unable to initialize frontend: Dialog
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y && apt-get install -y \
    curl locales tzdata 
     
RUN locale-gen en_US.UTF-8 zh_CN.UTF-8 

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8
RUN { \
        echo "LANG=$LANG"; \
        echo "LANGUAGE=$LANG"; \
        echo "LC_ALL=$LANG"; \
} > /etc/default/locale


ENV TZ=Asia/Chongqing
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN npm config set registry https://registry.npm.taobao.org
