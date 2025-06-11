FROM golang:1.24.4@sha256:8806e871f0a81b8a5e3165fb743bc1b80d92f6f8a0f0ff317b015c4adeffc0e2 as build
WORKDIR /app
COPY go.* *.go .
RUN CGO_ENABLED=0 go build -a -tags netgo -ldflags '-w -extldflags "-static"' *.go
FROM scratch
COPY --from=build --chmod=777 /app/single-paparazzogo /single-paparazzogo
EXPOSE 8080
ENTRYPOINT [ "/single-paparazzogo" ] 