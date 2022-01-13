FROM golang:1.17.6@sha256:0fa6504d3f1613f554c42131b8bf2dd1b2346fb69c2fc24a312e7cba6c87a71e as build
WORKDIR /app
COPY go.* *.go .
RUN CGO_ENABLED=0 go build -a -tags netgo -ldflags '-w -extldflags "-static"' *.go
FROM scratch
COPY --from=build --chmod=777 /app/single-paparazzogo /single-paparazzogo
EXPOSE 8080
ENTRYPOINT [ "/single-paparazzogo" ] 