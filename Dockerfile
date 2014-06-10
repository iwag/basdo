FROM iwag/centos:6.4
MAINTAINER iwag

RUN mkdir /services
ADD ./services /services
RUN /services/*/setup.sh
