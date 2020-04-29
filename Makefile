FORCE_REBUILD ?= 0
JITSI_RELEASE ?= unstable
JITSI_BUILD ?= latest
JITSI_REPO ?= jitsi
JITSI_SERVICES ?= base base-java web prosody jicofo jvb jigasi etherpad jibri

BUILD_ARGS := --build-arg JITSI_REPO=$(JITSI_REPO)
ifeq ($(FORCE_REBUILD), 1)
  BUILD_ARGS := $(BUILD_ARGS) --no-cache
endif


all:	build-all

release: tag-all push-all

build:
	$(MAKE) BUILD_ARGS="$(BUILD_ARGS)" JITSI_REPO="$(JITSI_REPO)" JITSI_RELEASE="$(JITSI_RELEASE)" -C $(JITSI_SERVICE) build

tag:
	docker tag $(JITSI_REPO)/$(JITSI_SERVICE):latest $(JITSI_REPO)/$(JITSI_SERVICE):$(JITSI_BUILD)

push:
	docker push $(JITSI_REPO)/$(JITSI_SERVICE):latest
	docker push $(JITSI_REPO)/$(JITSI_SERVICE):$(JITSI_BUILD)

%-all:
	@$(foreach SERVICE, $(JITSI_SERVICES), $(MAKE) --no-print-directory JITSI_SERVICE=$(SERVICE) $(subst -all,;,$@))

clean:
	docker-compose stop
	docker-compose rm
	docker network prune

prepare:
	docker pull debian:stretch-slim
	docker pull etherpad/etherpad
	FORCE_REBUILD=1 $(MAKE)

ecr-push:
	@echo etherpad
	M=`aws ecr batch-get-image --repository-name jitsi/etherpad --image-ids imageTag=latest --query 'images[].imageManifest' --output text` aws ecr put-image --repository-name jitsi/etherpad --image-tag previous --image-manifest "$M" --output text
	docker tag jitsi/etherpad 658483010266.dkr.ecr.af-south-1.amazonaws.com/jitsi/etherpad:${GIT_COMMIT}
	docker push 658483010266.dkr.ecr.af-south-1.amazonaws.com/jitsi/etherpad:${GIT_COMMIT}
	docker tag jitsi/etherpad 658483010266.dkr.ecr.af-south-1.amazonaws.com/jitsi/etherpad:latest
	docker push 658483010266.dkr.ecr.af-south-1.amazonaws.com/jitsi/etherpad:latest
	@echo jibri
	M=`aws ecr batch-get-image --repository-name jitsi/jibri --image-ids imageTag=latest --query 'images[].imageManifest' --output text` aws ecr put-image --repository-name jitsi/jibri --image-tag previous --image-manifest "$M" --output text
	docker tag jitsi/jibri 658483010266.dkr.ecr.af-south-1.amazonaws.com/jitsi/jibri:${GIT_COMMIT}
	docker push 658483010266.dkr.ecr.af-south-1.amazonaws.com/jitsi/jibri:${GIT_COMMIT}
	docker tag jitsi/jibri 658483010266.dkr.ecr.af-south-1.amazonaws.com/jitsi/jibri:latest
	docker push 658483010266.dkr.ecr.af-south-1.amazonaws.com/jitsi/jibri:latest
	@echo jicofo
	M=`aws ecr batch-get-image --repository-name jitsi/jicofo --image-ids imageTag=latest --query 'images[].imageManifest' --output text` aws ecr put-image --repository-name jitsi/jicofo --image-tag previous --image-manifest "$M" --output text
	docker tag jitsi/jicofo 658483010266.dkr.ecr.af-south-1.amazonaws.com/jitsi/jicofo:${GIT_COMMIT}
	docker push 658483010266.dkr.ecr.af-south-1.amazonaws.com/jitsi/jicofo:${GIT_COMMIT}
	docker tag jitsi/jicofo 658483010266.dkr.ecr.af-south-1.amazonaws.com/jitsi/jicofo:latest
	docker push 658483010266.dkr.ecr.af-south-1.amazonaws.com/jitsi/jicofo:latest
	@echo jigasi
	M=`aws ecr batch-get-image --repository-name jitsi/jigasi --image-ids imageTag=latest --query 'images[].imageManifest' --output text` aws ecr put-image --repository-name jitsi/jigasi --image-tag previous --image-manifest "$M" --output text
	docker tag jitsi/jigasi 658483010266.dkr.ecr.af-south-1.amazonaws.com/jitsi/jigasi:${GIT_COMMIT}
	docker push 658483010266.dkr.ecr.af-south-1.amazonaws.com/jitsi/jigasi:${GIT_COMMIT}
	docker tag jitsi/jigasi 658483010266.dkr.ecr.af-south-1.amazonaws.com/jitsi/jigasi:latest
	docker push 658483010266.dkr.ecr.af-south-1.amazonaws.com/jitsi/jigasi:latest
	@echo jvb
	M=`aws ecr batch-get-image --repository-name jitsi/jvb --image-ids imageTag=latest --query 'images[].imageManifest' --output text` aws ecr put-image --repository-name jitsi/jvb --image-tag previous --image-manifest "$M" --output text
	docker tag jitsi/jvb 658483010266.dkr.ecr.af-south-1.amazonaws.com/jitsi/jvb:${GIT_COMMIT}
	docker push 658483010266.dkr.ecr.af-south-1.amazonaws.com/jitsi/jvb:${GIT_COMMIT}
	docker tag jitsi/jvb 658483010266.dkr.ecr.af-south-1.amazonaws.com/jitsi/jvb:latest
	docker push 658483010266.dkr.ecr.af-south-1.amazonaws.com/jitsi/jvb:latest
	@echo prosody
	M=`aws ecr batch-get-image --repository-name jitsi/prosody --image-ids imageTag=latest --query 'images[].imageManifest' --output text` aws ecr put-image --repository-name jitsi/prosody --image-tag previous --image-manifest "$M" --output text
	docker tag jitsi/prosody 658483010266.dkr.ecr.af-south-1.amazonaws.com/jitsi/prosody:${GIT_COMMIT}
	docker push 658483010266.dkr.ecr.af-south-1.amazonaws.com/jitsi/prosody:${GIT_COMMIT}
	docker tag jitsi/prosody 658483010266.dkr.ecr.af-south-1.amazonaws.com/jitsi/prosody:latest
	docker push 658483010266.dkr.ecr.af-south-1.amazonaws.com/jitsi/prosody:latest
	@echo web
	M=`aws ecr batch-get-image --repository-name jitsi/web --image-ids imageTag=latest --query 'images[].imageManifest' --output text` aws ecr put-image --repository-name jitsi/web --image-tag previous --image-manifest "$M" --output text
	docker tag jitsi/web 658483010266.dkr.ecr.af-south-1.amazonaws.com/jitsi/web:${GIT_COMMIT}
	docker push 658483010266.dkr.ecr.af-south-1.amazonaws.com/jitsi/web:${GIT_COMMIT}
	docker tag jitsi/web 658483010266.dkr.ecr.af-south-1.amazonaws.com/jitsi/web:latest
	docker push 658483010266.dkr.ecr.af-south-1.amazonaws.com/jitsi/web:latest


ecs-configure:
	ecs-cli configure --cluster lon-conf-telviva-com --default-launch-type EC2 --region eu-west-2 --config-name lon-conf-telviva-com

ecs-up:
	ecs-cli up --keypair Steve --capability-iam --size 1 --instance-type m4.xlarge --launch-type EC2

ecs-compose:
	( cd deploy/lon-conf-telviva-com; ecs-cli compose --file docker-compose.yml up )

.PHONY: all build tag push clean prepare
