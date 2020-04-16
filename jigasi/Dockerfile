ARG JITSI_REPO=jitsi
FROM ${JITSI_REPO}/base-java

ENV GOOGLE_APPLICATION_CREDENTIALS /config/key.json

RUN \
	apt-dpkg-wrap apt-get update && \
	apt-dpkg-wrap apt-get install -y jigasi jq && \
	apt-cleanup

COPY rootfs/ /

ADD jigasi-linux-x64-1.1-SNAPSHOT.tar.gz /usr/share

RUN \
	cd /usr/share && \
	cp jigasi/collect-dump-logs.sh jigasi-linux-x64-1.1-SNAPSHOT/collect-dump-logs.sh && \
	mv jigasi jigasi.old && mv jigasi-linux-x64-1.1-SNAPSHOT jigasi

VOLUME ["/config", "/tmp/transcripts"]
