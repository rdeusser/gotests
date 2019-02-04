SHELL := /bin/bash
GOPATH=$(shell go env | grep GOPATH | cut -d \" -f 2)

# Setup name variables for the package/tool.
NAME := gotests
PKG := github.com/rdeusser/$(NAME)

# Set any default go build tags.
BUILDTAGS :=
# Set ldflags.
LDFLAGS=-ldflags "-w"

.PHONY: build
build: clean $(NAME) # Builds a dynamic executable or package

.PHONY: clean
clean: # Removes generated files
	@rm -f $(NAME)

$(NAME): $(wildcard *.go) $(wildcard */*.go)
	@go build -tags "$(BUILDTAGS)" $(LDFLAGS) -o $(NAME) ./cmd/$(NAME)

.PHONY: deps
deps: # Runs `go mod tidy`
	@GO111MODULE=off go get -u golang.org/x/lint/golint
	@GO111MODULE=off go get -u github.com/mjibson/esc
	@go mod tidy
	@go mod download

.PHONY: fmt
fmt: # Verifies all files have been `gofmt`ed
	@gofmt -s -l . | grep -v '.pb.go:' | tee /dev/stderr

.PHONY: generate
generate: ## Runs `go generate`
	@go generate ./... | grep -v '.pb.go:' | tee /dev/stderr

.PHONY: lint
lint: # Verifies `golint` passes
	@golint ./... | grep -v '.pb.go:' | tee /dev/stderr

.PHONY: test
test: # Runs the go tests
	@go test -v -tags "$(BUILDTAGS)" $(shell go list ./... | grep -v vendor)

.PHONY: testall
testall: # Runs all go tests (including benchmarks)
	@go test -v -bench=. -race -tags "$(BUILDTAGS)" $(shell go list ./... | grep -v vendor)

.PHONY: vet
vet: # Verifies `go vet` passes
	@go vet $(shell go list ./... | grep -v vendor) | grep -v '.pb.go:' | tee /dev/stderr

.PHONY: cover
cover: # Runs go test with coverage
	@for d in $(shell go list ./... | grep -v vendor); do \
		go test -race -coverprofile=profile.out -covermode=atomic "$$d"; \
		if [ -f profile.out ]; then \
			rm profile.out; \
		fi; \
	done;

.PHONY: install
install: # Installs the executable or package
	@go install -a -tags "$(BUILDTAGS)" ${LDFLAGS} ./cmd/$(NAME)
