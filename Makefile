DOCKER_API_NAME = api-gateway-scaffold
DOCKER_ORG_NAME = vcovre

build:
	@echo ">> Docker: Building app \n"
	docker-compose build

image/build:
	@echo ">> Docker: Building image for deploy \n"
	docker build . --target production -t $(DOCKER_ORG_NAME)/$(DOCKER_API_NAME):${TAG}

image/push:
	@echo ">> Docker: Pushing built image \n"
	docker push $(DOCKER_ORG_NAME)/$(DOCKER_API_NAME):${TAG}

install:
	@echo ">> Installing dependencies \n"
	npm install

start:
	@echo ">> Starting app \n"
	docker-compose up --build

start/watch:
	@echo ">> Starting app [watch mode] \n"
	npm run start:watch

lint:
	@echo ">> Running linter \n"
	docker-compose run $(DOCKER_API_NAME) npm run lint

.PHONY: test
test:
	@echo ">> Testing app \n"
	docker-compose run $(DOCKER_API_NAME) npm test

test/watch:
	@echo ">> Watching changes on tests \n"
	docker-compose run -e NODE_ENV=test $(DOCKER_API_NAME) npm run test:watch
