.PHONY: docker run start stop open go

PORT = 3000
TAG = ledger-web

DOCKERFILE = Dockerfile
SRCS = config.json

go : run
	python -m webbrowser -t 'http://localhost:$(PORT)'

# Build and start container if it's not running.

DOCKER_BUILD = .docker-build

CONTAINER := $(shell docker ps | tail -n+2 | awk '{print $$2}' | grep '$(TAG)')

run : $(DOCKER_BUILD)
	test -n "$(CONTAINER)" || \
		docker run --name $(TAG) --rm --read-only \
			-p 3000:3000 -p 3001:3001 \
			-v ~/org:/mnt/ledger $(TAG) &>/dev/null &

$(DOCKER_BUILD) : $(DOCKERFILE) $(SRCS)
	docker build --rm --tag $(TAG) -f $(DOCKERFILE) .
	touch .docker-build

start :
	docker start $(TAG)

stop :
	docker stop $(TAG)
