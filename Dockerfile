# Minecraft 1.10.2 Dockerfile

FROM java:openjdk-7-jre

MAINTAINER Noah Prail <noah@prail.net>

ENV MC-VERSION 1.10.2

RUN apt-get -y update && \
    apt-get -y install wget git && \
    apt-get clean


RUN mkdir -p /tmp/sp
RUN mkdir -p /mcdata

WORKDIR /tmp/sp
# Download BuildTools.jar
RUN wget -q https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar

# Build the Jar 
RUN java -jar BuildTools.jar --rev ${MC-VERSION}

RUN cp spigot-${MC-VERSION}.jar /


# Expose the container's network port: 25565 during runtime.
EXPOSE 25565

# Automatically accept Minecraft EULA, and start Minecraft server
ENV JVM_OPTS -Xmx1024M -Xms1024M
VOLUME [ "/mcdata" ]
CMD echo eula=true > /data/eula.txt && java -jar /spigot-${MC-VERSION}.jar
