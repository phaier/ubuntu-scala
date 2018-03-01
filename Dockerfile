FROM ubuntu:17.10

MAINTAINER Toshiaki Inahata <darwin49@gmail.com>


#
# Set UP Ubuntu
RUN apt-get update && apt-get upgrade -y && apt-get install -y git curl wget unzip vim


#
# Install Node.js
RUN apt-get install -y nodejs npm
RUN npm cache clean
RUN npm install n -g
RUN n 8.9.4
RUN apt-get purge -y nodejs npm
RUN echo 'ln -s /usr/local/bin/npm /usr/bin/npm' >> ~/.bashrc


#
# Set UP yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update
RUN apt-get install -y yarn


#
# Set UP Java 8
RUN apt-get install -y openjdk-8-jre && apt-get install -y openjdk-8-jdk


#
# Set UP scalaenv
RUN git clone git://github.com/scalaenv/scalaenv.git /root/.scalaenv
ENV PATH $PATH:/root/.scalaenv/bin
RUN echo 'eval \"$(scalaenv init -)\"' >> /root/.bashrc
RUN eval "$(scalaenv init -)"
RUN scalaenv install scala-2.12.4
RUN scalaenv global scala-2.12.4


#
# Set UP stbenv
RUN git clone git://github.com/sbtenv/sbtenv.git /root/.sbtenv
ENV PATH $PATH:/root/.sbtenv/bin
RUN echo 'eval \"$(sbtenv init -)\"' >> /root/.bashrc
RUN eval "$(sbtenv init -)"
RUN apt-get install dirmngr
RUN gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv 99E82A75642AC823
RUN sbtenv install sbt-1.1.0
RUN sbtenv global sbt-1.1.0
