DOCKER_TAG?=latest
export DOCKER_TAG

setup:
	go get github.com/golang/dep/cmd/dep
	dep ensure

build:
	GOOS=linux GOARCH=386 go build -o docker-user-auth .

build-release:
	go vet .
	GOOS=linux GOARCH=386 go build -ldflags="-s -w" -o quantum .

clean:
	rm -rf vendor
	rm quantum ||:

updatedep:
	rm -rf vendor
	dep ensure -update

run:
	go run *.go

unit-test:
	go list ./... | grep -v vendor | xargs go test -v

assets:
	rm static/keys.go ||:
	go get -u github.com/jteeuwen/go-bindata/...
	go-bindata -pkg static -o static/keys.go static/


docker-multistage:
	docker build -f Dockerfile.build -t quantum:$(DOCKER_TAG) .
