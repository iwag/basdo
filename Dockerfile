# name iwag/buildstep

FROM centos:6.4
MAINTAINER iwag

RUN mkdir /common
ADD ./common /common
RUN sh /common/setup.sh

RUN mkdir /services
ADD ./services /services
RUN sh /services/*/setup.sh

EXPOSE 22
CMD /usr/sbin/sshd -D
