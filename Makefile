HELM_PLUGIN_NAME := mapkubeapis
LDFLAGS := "-X main.version=${VERSION}"
MOD_PROXY_URL ?= https://goproxy.io

.PHONY: build
build:
	export CGO_ENABLED=0 && \
	go build -o bin/${HELM_PLUGIN_NAME} -ldflags $(LDFLAGS) ./map_kube_apis.go

.PHONY: bootstrap
bootstrap:
	export GO111MODULE=on && \
	export GOPROXY=$(MOD_PROXY_URL) && \
	go mod download

.PHONY: tag
tag:
	@scripts/tag.sh