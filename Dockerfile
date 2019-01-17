FROM ubuntu:latest
LABEL maintainer="David <david@cninone.com>"

# Get noninteractive frontend for Debian to avoid some problems:
#    debconf: unable to initialize frontend: Dialog
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y && apt-get install -y \
    curl libltdl-dev gnupg locales tzdata 
     
RUN locale-gen en_US.UTF-8 zh_CN.UTF-8 ; mkdir -p /var/run/sshd

ENV LANG en_US.UTF-8
RUN { \
        echo "LANG=$LANG"; \
        echo "LANGUAGE=$LANG"; \
        echo "LC_ALL=$LANG"; \
} > /etc/default/locale
RUN useradd -ms /bin/bash david && usermod -aG sudo david ; \
        echo 'david:freego' | chpasswd ; echo 'root:freego_2019' | chpasswd


ENV TZ=Asia/Chongqing
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN curl -sL https://deb.nodesource.com/setup_11.x | bash - && apt-get install -y nodejs
# apt-get install -y build-essential

# ENTRYPOINT ["/init.sh"]
