FROM golang:1.18.5@sha256:fb249eca1b9172732de4950b0fb0fb5c231b83c2c90952c56d822d8a9de4d64b as build
WORKDIR /app
COPY go.* *.go .
RUN CGO_ENABLED=0 go build -a -tags netgo -ldflags '-w -extldflags "-static"' *.go
FROM scratch
COPY --from=build --chmod=777 /app/single-paparazzogo /single-paparazzogo
EXPOSE 8080
ENTRYPOINT [ "/single-paparazzogo" ] 