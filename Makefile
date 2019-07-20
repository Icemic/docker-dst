# Don't Starve Together Dedicated Server
# Makefile
#
# Copyright (c) 2019, Winston Astrachan

help:
	@echo ""
	@echo "Usage: make <target>"
	@echo ""
	@echo "Docker Don't Starve Together Makefile"
	@echo ""
	@echo "Targets:"
	@echo "  build           Build and tag image"
	@echo "  clean           Mark image for rebuild"
	@echo "  delete          Untag image and mark for rebuild"
	@echo ""
	@echo "  start           Start container in the background"
	@echo "  stop            Stop container"
	@echo ""

.PHONY: build
build: .dst-server.img

.dst-server.img:
	docker build -t wastrachan/dst-server:latest .
	@touch .dst-server.img

.PHONY: clean
clean:
	@rm -rf .dst-server.img || true

.PHONY: delete
delete: clean
	@docker rm dst-server || true
	@docker rmi wastrachan/dst-server:latest || true

.PHONY: start
start: build
	docker run \
		-d \
		--rm \
		--name dst-server \
		-v "$(CURDIR)/data:/dst" \
		-p 27016:27016/tcp \
		-p 10999:10999/udp \
		wastrachan/dst-server:latest

.PHONY: stop
stop:
	docker stop dst-server
