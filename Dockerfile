FROM golang:1.20.4@sha256:1a03e9e3cdc761ca91f5883dee232b1cb5c76514fc16581ec5b11991c5f3fb1d as build
WORKDIR /app
COPY go.* *.go .
RUN CGO_ENABLED=0 go build -a -tags netgo -ldflags '-w -extldflags "-static"' *.go
FROM scratch
COPY --from=build --chmod=777 /app/single-paparazzogo /single-paparazzogo
EXPOSE 8080
ENTRYPOINT [ "/single-paparazzogo" ] 