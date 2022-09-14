FROM golang:1.19.1@sha256:02f2932b7bc3cbd6f7da8cbcd8bbfb0ceed3641a67c23e6e23589df549918fce as build
WORKDIR /app
COPY go.* *.go .
RUN CGO_ENABLED=0 go build -a -tags netgo -ldflags '-w -extldflags "-static"' *.go
FROM scratch
COPY --from=build --chmod=777 /app/single-paparazzogo /single-paparazzogo
EXPOSE 8080
ENTRYPOINT [ "/single-paparazzogo" ] 