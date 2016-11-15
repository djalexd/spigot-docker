FROM java:openjdk-7-jre

MAINTAINER Noah Prail <noah@prail.net>

ENV MC_VERSION 1.10.2

RUN apt-get -y update && \
    apt-get -y install wget git && \
    apt-get clean

RUN mkdir -p /tmp/sp
RUN mkdir -p /mcdata

WORKDIR /tmp/sp

RUN wget -q https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar

RUN java -jar BuildTools.jar --rev ${MC_VERSION}

RUN cp spigot-${MC_VERSION}.jar /mcdata/
RUN rm /tmp/sp -r

WORKDIR /mcdata

EXPOSE 25565

ENV JVM_OPTS -Xmx1024M -Xms1024M -XX:MaxPermSize=128M
VOLUME [ "/mcdata" ]
CMD echo eula=true > eula.txt && ls && java -Xmx1024M -Xms1024M -XX:MaxPermSize=128M -jar spigot-${MC_VERSION}.jar
