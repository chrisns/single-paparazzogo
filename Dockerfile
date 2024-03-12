FROM golang:1.22.1@sha256:99c5da0eb0ffe1a01e46f54c3a6783df4d8a49bd3c16fbb3ac74c6e711541a93 as build
WORKDIR /app
COPY go.* *.go .
RUN CGO_ENABLED=0 go build -a -tags netgo -ldflags '-w -extldflags "-static"' *.go
FROM scratch
COPY --from=build --chmod=777 /app/single-paparazzogo /single-paparazzogo
EXPOSE 8080
ENTRYPOINT [ "/single-paparazzogo" ] 