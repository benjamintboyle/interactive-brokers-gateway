FROM centos
#FROM alpine

RUN yum -y install which Xvfb libXrender libXtst && yum -y update; yum clean all
#RUN apk add --no-cache xvfb

RUN ["adduser", "-m", "-p", "gatekeeper", "gatekeeper"]

COPY tws-stable-standalone-linux-x64.sh /home/gatekeeper/
COPY IBController /opt/IBController/

RUN ["chmod", "-R", "777", "/home/gatekeeper/tws-stable-standalone-linux-x64.sh", "/opt/IBController/"]

USER gatekeeper
WORKDIR /home/gatekeeper/

#RUN Xvfb :99 &
#RUN export DISPLAY=:99

RUN mkdir /home/gatekeeper/IBController && cp /opt/IBController/IBController.ini /home/gatekeeper/IBController/

RUN ["./tws-stable-standalone-linux-x64.sh", "-q", "-Dinstall4j.keepLog=true"]

RUN ["rm", "tws-stable-standalone-linux-x64.sh"]
