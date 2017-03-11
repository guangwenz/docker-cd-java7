FROM openjdk:7
MAINTAINER Guangwen Zhou <zgwmike@hotmail.com>

ARG         DEBIAN_FRONTEND=noninteractive
ENV 	BUILDMASTER localhost
ENV 	BUILDMASTER_PORT 9989
ENV 	WORKERNAME docker

COPY buildbot.tac /buildbot/buildbot.tac
RUN         apt-get update && \
            apt-get -y upgrade && \
            apt-get -y install -q \
                build-essential \
                git \
                python-dev \
                libffi-dev \
                libssl-dev \
                python-pip \
                curl && \
            rm -rf /var/lib/apt/lists/* && \
            curl -Lo /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.1.3/dumb-init_1.1.3_amd64 && \
            chmod +x /usr/local/bin/dumb-init 

RUN			pip install -U pip virtualenv && \
            pip install --upgrade cffi && \
            pip install 'twisted[tls]' && \
            pip install -U setuptools && \
            pip install buildbot-worker && \
            useradd -ms /bin/bash buildbot && chown -R buildbot /buildbot
USER buildbot
WORKDIR /buildbot

CMD ["/usr/local/bin/dumb-init", "twistd", "-ny", "buildbot.tac"]