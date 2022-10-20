# Dockerfile
#
# VERSION               0.1

FROM debian:stretch-backports
MAINTAINER Xiwen Cheng <x@cinaq.com>

# Setup mono
RUN apt update && apt install -y openjdk-11-jdk sqlite3 apt-transport-https dirmngr gnupg ca-certificates curl
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
# Use stable-stretch/snapshots/5.20.1 instead of stable-stretch to pin to older version; default to latest
RUN echo "deb https://download.mono-project.com/repo/debian stable-stretch main" | tee /etc/apt/sources.list.d/mono-official-stable.list
# mono-runtime is not enough apparently
RUN apt update && apt install -y mono-devel
RUN apt-get clean

RUN mkdir -p /srv/mendix/package

COPY ./bin/* /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/mendix-build"]
