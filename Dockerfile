# name iwag/buildstep

#FROM centos:6.4
FROM iwag/ruby-misc
MAINTAINER iwag

RUN mkdir /common
ADD ./common /common
RUN sh /common/setup.sh

RUN mkdir /services
ADD ./services /services
RUN ls -1 /services/*/setup.sh | xargs cat | bash 

EXPOSE 22
CMD /usr/sbin/sshd -D
