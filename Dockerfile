FROM oysteinjakobsen/armv7-oracle-java8

MAINTAINER Hexagon MC <admin@hexagonminecraft.com>

ARG MC_VERSION=1.11.2

RUN apt-get -y update && apt-get --no-install-recommends -y install wget git

RUN mkdir -p /tmp/sp && \
    mkdir -p /mcdata

WORKDIR /tmp/sp

RUN wget -q https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar && \
    java -jar BuildTools.jar --rev ${MC_VERSION} && \
    cp spigot-${MC_VERSION}.jar /mcdata/ && \
    rm -r /tmp/sp

WORKDIR /mcdata

RUN echo eula=true > eula.txt

EXPOSE 25565

ENV JVM_OPTS -Xmx1024M -Xms1024M -XX:MaxPermSize=128M

VOLUME [ "/mcdata" ]

CMD java ${JVM_OPTS} -jar spigot-${MC_VERSION}.jar
