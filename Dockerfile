FROM centos
#FROM alpine

RUN yum -y install which Xvfb libXrender libXtst less \
      && yum -y update \
      && yum clean all
#RUN apk add --no-cache xvfb

RUN ["adduser", "-m", "-p", "gatekeeper", "gatekeeper"]

COPY IBController/ /opt/IBController/
COPY tws-stable-standalone-linux-x64.sh config/ /home/gatekeeper/
RUN chmod -R 755 /opt/IBController/ \
      && chown -R gatekeeper:gatekeeper /home/gatekeeper/IBController/ /home/gatekeeper/tws-stable-standalone-linux-x64.sh \
      && chmod 755 /home/gatekeeper/IBController/locales.jar \
      && chmod 755 /home/gatekeeper/IBController/dggcnxaymn/language.jar \
      && chmod -R 400 /home/gatekeeper/IBController/IBController.ini

# Install script fails if not launched from home directory
USER gatekeeper
WORKDIR /home/gatekeeper/
RUN /home/gatekeeper/tws-stable-standalone-linux-x64.sh -q \
      && rm /home/gatekeeper/tws-stable-standalone-linux-x64.sh

# Script fails if not launched from this directory
WORKDIR /opt/IBController/
CMD xvfb-run ./IBControllerGatewayStart.sh > /home/gatekeeper/IBController/IBControllerGatewayStart.sh.log
