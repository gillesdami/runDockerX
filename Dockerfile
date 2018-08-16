FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive 
ENV DEBCONF_NONINTERACTIVE_SEEN=true

ARG REPOSITORY=
RUN echo "${REPOSITORY}" >> /etc/apt/sources.list

ARG PACKAGE=
RUN apt-get update && apt-get install -qqy x11-apps ${PACKAGE}

ARG DISPLAY=:0
ENV DISPLAY ${DISPLAY}
ARG PROGRAM
ENV PROGRAM ${PROGRAM}

CMD ${PROGRAM}

# $ XSOCK=/tmp/.X11-unix
# $ XAUTH=/tmp/.docker.xauth
# $ xauth nlist $@ | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -
# $ docker run -ti -v $XSOCK:$XSOCK -v $XAUTH:$XAUTH -e XAUTHORITY=$XAUTH name