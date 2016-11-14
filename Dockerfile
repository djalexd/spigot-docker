# Minecraft 1.10.2 Dockerfile

FROM debian:wheezy

MAINTAINER Noah Prail <noah@prail.net>

ENV MC-VERSION 1.10.2

RUN apt-get -y update && \
    apt-get -y install openjdk-7-jre-headless wget git && \
    apt-get clean

# Download BuildTools.jar
RUN wget -q https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar

# Build the Jar 
RUN java -jar BuildTools.jar --rev ${MC-VERSION}

WORKDIR /data
VOLUME /data

# Expose the container's network port: 25565 during runtime.
EXPOSE 25565

# Automatically accept Minecraft EULA, and start Minecraft server
CMD echo eula=true > /data/eula.txt && java -jar /spigot-${MC-VERSION}.jar
