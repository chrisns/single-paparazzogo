FROM golang:1.24.2@sha256:8131d99bd9bdf38a3b9720c23c3d21f40d65137d4b2fd2eccab20e7ab7b5dee4 as build
WORKDIR /app
COPY go.* *.go .
RUN CGO_ENABLED=0 go build -a -tags netgo -ldflags '-w -extldflags "-static"' *.go
FROM scratch
COPY --from=build --chmod=777 /app/single-paparazzogo /single-paparazzogo
EXPOSE 8080
ENTRYPOINT [ "/single-paparazzogo" ] 