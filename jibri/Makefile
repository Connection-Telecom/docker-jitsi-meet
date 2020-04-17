build:
	if [ ../../jibri/target/jibri-8.0-SNAPSHOT-jar-with-dependencies.jar -nt jibri.jar ]; then echo Copying newer jibri.jar file from jibri build >&2; cp ../../jibri/target/jibri-8.0-SNAPSHOT-jar-with-dependencies.jar jibri.jar; fi
	docker build $(BUILD_ARGS) -t $(JITSI_REPO)/jibri .

.PHONY: build
