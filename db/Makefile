# Makefile for building and deploying a container image to Azure Container Registry (ACR)

# Azure Container Registry settings
ACR_NAME = cfsecops.azurecr.io
IMAGE_NAME = postgres
IMAGE_TAG = latest

# Docker settings
DOCKERFILE = Dockerfile

# Build and push Docker image
docker-build:
	docker build -t $(IMAGE_NAME):$(IMAGE_TAG) -f $(DOCKERFILE) .

docker-push:
	az acr login --name $(ACR_NAME)
	docker tag $(IMAGE_NAME):$(IMAGE_TAG) $(ACR_NAME)/$(IMAGE_NAME):$(IMAGE_TAG)
	docker push $(ACR_NAME)/$(IMAGE_NAME):$(IMAGE_TAG)

# Deploy the container image to ACR
deploy-to-acr: docker-build docker-push
	@echo "Container image deployed to Azure Container Registry (ACR)"

# Clean u
clean:
	docker rmi $(IMAGE_NAME):$(IMAGE_TAG) || true
	docker rmi $(ACR_NAME)/$(IMAGE_NAME):$(IMAGE_TAG) || true

.PHONY: docker-build docker-push deploy-to-acr clean