FROM golang:1.18.0@sha256:7a3cc1bd39e3937b4eddd2e66c4ed7c1852a4e7fa42b73507ed4ee50c02978a4 as build
WORKDIR /app
COPY go.* *.go .
RUN CGO_ENABLED=0 go build -a -tags netgo -ldflags '-w -extldflags "-static"' *.go
FROM scratch
COPY --from=build --chmod=777 /app/single-paparazzogo /single-paparazzogo
EXPOSE 8080
ENTRYPOINT [ "/single-paparazzogo" ] 