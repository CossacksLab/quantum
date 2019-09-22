FROM golang:latest

WORKDIR //TODO
COPY . .

RUN make setup assets build-release


FROM alpine:latest
RUN apk --no-cache add ca-certificates

RUN mkdir -p /opt/release

CMD ["/opt/release/quantum"]