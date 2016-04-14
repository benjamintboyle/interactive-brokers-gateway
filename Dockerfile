FROM alpine

RUN ["adduser", "-D", "gatekeeper"]

COPY tws-stable-standalone-linux-x64.sh /home/gatekeeper/

RUN ["chmod", "777", "/home/gatekeeper/tws-stable-standalone-linux-x64.sh"]

USER gatekeeper
WORKDIR /home/gatekeeper/

RUN ["./tws-stable-standalone-linux-x64.sh", "-q"]

RUN ["rm", "tws-stable-standalone-linux-x64.sh"]
