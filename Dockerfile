FROM centos
#FROM alpine

RUN yum -y install which Xvfb libXrender libXtst && yum -y update; yum clean all
#RUN apk add --no-cache xvfb

RUN ["adduser", "-m", "-p", "gatekeeper", "gatekeeper"]
WORKDIR /home/gatekeeper/

COPY IBController/ /opt/IBController/
COPY tws-stable-standalone-linux-x64.sh config/ /home/gatekeeper/
RUN chmod -R 755 /opt/IBController/ \
      && chown -R gatekeeper:gatekeeper /home/gatekeeper/IBController/ tws-stable-standalone-linux-x64.sh \
      && chmod 755 /home/gatekeeper/IBController/locales.jar \
      && chmod 755 /home/gatekeeper/IBController/dggcnxaymn/language.jar \
      && chmod -R 400 /home/gatekeeper/IBController/IBController.ini

USER gatekeeper
RUN /home/gatekeeper/tws-stable-standalone-linux-x64.sh -q \
      && rm tws-stable-standalone-linux-x64.sh

#RUN Xvfb :99 &
#RUN export DISPLAY=:99

#CMD ["/opt/IBController/IBControllerGatewayStart.sh"]
