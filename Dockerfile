FROM debian:9

RUN apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get install -y lxde tightvncserver nano vim curl && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

COPY home/ /data/home
COPY setup-start /usr/bin

CMD ["setup-start"]
EXPOSE 5901