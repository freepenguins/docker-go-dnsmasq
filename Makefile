NS = vp
NAME = go-dnsmasq
VERSION = 1
LOCAL_TAG = $(NS)/$(NAME):$(VERSION)

REGISTRY = callforamerica
ORG = vp
REMOTE_TAG = $(REGISTRY)/$(NAME):$(VERSION)

GITHUB_REPO = docker-go-dnsmasq
DOCKER_REPO = go-dnsmasq
BUILD_BRANCH = master

.PHONY: all build test release shell run start stop rm rmi default

all: build

checkout:
	@git checkout $(BUILD_BRANCH)

build:
	@docker build -t $(LOCAL_TAG) --rm .
	$(MAKE) tag

tag:
	@docker tag -f $(LOCAL_TAG) $(REMOTE_TAG)

rebuild:
	@docker build -t $(LOCAL_TAG) --rm --no-cache .

test:
	@rspec ./tests/*.rb

commit:
	@git add -A .
	@git commit

deploy:
	@docker push $(REMOTE_TAG)

push:
	@git push origin master

shell:
	@docker exec -ti $(NAME) /bin/ash

run:
	@docker run -it --rm --name $(NAME) $(LOCAL_TAG)

launch:
	@docker run -d --name $(NAME) $(LOCAL_TAG)

logs:
	@docker logs $(NAME)

logsf:
	@docker logs -f $(NAME)

start:
	@docker start $(NAME)

stop:
	@docker stop $(NAME)

rm:
	@docker rm $(NAME)

rmi:
	@docker rmi $(LOCAL_TAG)
	@docker rmi $(REMOTE_TAG)

default: build