ARG JITSI_REPO=jitsi
FROM ${JITSI_REPO}/base

COPY rootfs/ /

RUN \
	apt-dpkg-wrap apt-get update && \
	apt-dpkg-wrap apt-get install -y cron nginx-extras jitsi-meet-web && \
	apt-dpkg-wrap apt-get install -y -t stretch-backports certbot && \
	apt-dpkg-wrap apt-get -d install -y jitsi-meet-web-config && \
	dpkg -x /var/cache/apt/archives/jitsi-meet-web-config*.deb /tmp/pkg && \
	mv /tmp/pkg/usr/share/jitsi-meet-web-config/config.js /defaults && \
	mv /usr/share/jitsi-meet/interface_config.js /defaults && \
	cd /usr/share/jitsi-meet/images && mv watermark.png watermark-jitsi.png && ln -s /config/watermark.png watermark.png && \
	ln -s /config/favicon.png favicon.png && \
	ln -s /config/logo.png logo.png && \
	cd /usr/share/jitsi-meet/static && mv close2.html close2.html.orig && ln -s /config/close2.html close2.html && \
	cd /usr/share/jitsi-meet/lang && mv main.json main.json.orig && ln -s /config/lang-main.json main.json && \
	mv main-enGB.json main-enGB.json.orig && ln -s /config/lang-main-enGB.json main-enGB.json && \
	cd /usr/share/jitsi-meet && mv title.html title.html.orig && ln -s /config/title.html title.html && cd / && \
	apt-cleanup && \
	rm -f /etc/nginx/conf.d/default.conf && \
	rm -rf /tmp/pkg /var/cache/apt

EXPOSE 80 443

VOLUME ["/config", "/etc/letsencrypt", "/usr/share/jitsi-meet/transcripts"]
