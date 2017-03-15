# docker-cd-java7

Packages installed
# OpenJDK 7
# git
# python 2.7
# buildbot-worker
# ansible
# sbt


```
docker build -t buildbot-worker-java7 .
docker run --rm -e BUILDMASTER=THE_BUILDMASTER_HOST -e BUILDMASTER_PORT=9989 -e WORKERNAME=linux-jdk7-1 -e WORKERPASS=PASS buildbot-worker-java7
```
