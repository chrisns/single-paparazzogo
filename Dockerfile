FROM golang:1.18.1@sha256:12d3995156cb0dcdbb9d3edb5827e4e8e1bf5bf92436bfd12d696ec997001a9a as build
WORKDIR /app
COPY go.* *.go .
RUN CGO_ENABLED=0 go build -a -tags netgo -ldflags '-w -extldflags "-static"' *.go
FROM scratch
COPY --from=build --chmod=777 /app/single-paparazzogo /single-paparazzogo
EXPOSE 8080
ENTRYPOINT [ "/single-paparazzogo" ] 