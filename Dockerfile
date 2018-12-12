FROM debian:9

ENV USER=root
ENV RESOLUTION=1280x800
ENV HOME=/root
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=C.UTF-8
ENV REMOTE_HOST=localhost
ENV REMOTE_PORT=5901
USER root

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y lxde tightvncserver autocutsel vim curl gnupg \
 && rm -rf /var/lib/apt/lists/* \
 && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
 && apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y git software-properties-common supervisor \
 && git clone https://github.com/novnc/noVNC.git /root/noVNC \
 && git clone https://github.com/novnc/websockify /root/noVNC/utils/websockify \
 && rm -rf /root/noVNC/.git \
 && rm -rf /root/noVNC/utils/websockify/.git \
 && cd /root/noVNC \	
 && npm install npm@latest \
 && npm install \
 && ./utils/use_require.js --as commonjs --with-app \
 && cp /root/noVNC/node_modules/requirejs/require.js /root/noVNC/build \
 && sed -i -- "s/ps -p/ps -o pid | grep/g" /root/noVNC/utils/launch.sh \
 && apt-get remove -y git nodejs \
 && apt-get autoremove -y \
 && apt-get clean -y
 
COPY home/root/.vnc /root/.vnc
COPY entrypoint.sh /usr/bin/entrypoint.sh
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf 

RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["/usr/bin/entrypoint.sh"]

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

EXPOSE 8080
