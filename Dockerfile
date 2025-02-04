FROM golang:1.23.5@sha256:e213430692e5c31aba27473cdc84cfff2896d0c097e984bef67b6a44c75a8181 as build
WORKDIR /app
COPY go.* *.go .
RUN CGO_ENABLED=0 go build -a -tags netgo -ldflags '-w -extldflags "-static"' *.go
FROM scratch
COPY --from=build --chmod=777 /app/single-paparazzogo /single-paparazzogo
EXPOSE 8080
ENTRYPOINT [ "/single-paparazzogo" ] 