FROM golang:1.22.2@sha256:83d3f5ddeb0687a6fe2ffad3c76397f5e4d0a30d35fc4a5262e28dd52e6f7d7d as build
WORKDIR /app
COPY go.* *.go .
RUN CGO_ENABLED=0 go build -a -tags netgo -ldflags '-w -extldflags "-static"' *.go
FROM scratch
COPY --from=build --chmod=777 /app/single-paparazzogo /single-paparazzogo
EXPOSE 8080
ENTRYPOINT [ "/single-paparazzogo" ] 