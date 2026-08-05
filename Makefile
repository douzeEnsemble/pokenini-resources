# Executables (local)
DOCKER_COMP = docker compose

# Misc
.DEFAULT_GOAL = help

## —— 🎵 🐳 The Symfony-docker Makefile 🐳 🎵 ——————————————————————————————————
.PHONY: help
help: ## Outputs this help screen
	@grep -E '(^[a-zA-Z0-9\./_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}{printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

## —— Copy from icons 📋 ————————————————————————————————————————————————————————————————
.PHONY: copy
copy: ## Copy from icons
	cp -R ../pokenini-icon/images/* .

## —— Host images 🌐 ————————————————————————————————————————————————————————————————
.PHONY: host
host: ## Hosting the images
	$(DOCKER_COMP) up --wait

.PHONY: start
start: ## Hosting the images
start: host

.PHONY: unhost
unhost: ## Stop hosting
	$(DOCKER_COMP) down --remove-orphans

.PHONY: stop
stop: ## Stop hosting
stop: unhost

## —— Image 🐳 ———————————————————————————————————————————————————————————————
.PHONY: img-build
img-build: ## Build Docker image
	docker build -f ./.docker/web/Dockerfile -t ghcr.io/douzeensemble/pokenini-resources:latest .
	docker push ghcr.io/douzeensemble/pokenini-resources:latest
