.PHONY: docker run

TAG = ledger-web

DOCKERFILE = Dockerfile
SRCS = $(DOCKERFILE) config.json

run : docker
	docker run --rm $(TAG) -l $(TAG) --readonly -v $${HOME}/org:/mnt/ledger

docker : $(SRCS)
	docker build --rm --tag $(TAG) -f $(DOCKERFILE) .
