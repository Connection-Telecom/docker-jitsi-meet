build:
	if [ ../../jigasi/target/jigasi-linux-x64-1.1-SNAPSHOT.zip -nt jigasi-linux-x64-1.1-SNAPSHOT.zip ]; then echo Copying newer jigasi zip file from jigasi build >&2; cp ../../jigasi/target/jigasi-linux-x64-1.1-SNAPSHOT.zip .; fi
	rm -rf jigasi-linux-x64-1.1-SNAPSHOT && true
	unzip jigasi-linux-x64-1.1-SNAPSHOT.zip
	tar czf jigasi-linux-x64-1.1-SNAPSHOT.tar.gz jigasi-linux-x64-1.1-SNAPSHOT
	rm -rf jigasi-linux-x64-1.1-SNAPSHOT
	docker build $(BUILD_ARGS) -t $(JITSI_REPO)/jigasi .

.PHONY: build
