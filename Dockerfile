FROM golang:1.27.1@sha256:f773aa2679c165b2d4ccf04c1de9ef5f34c0e4fd7008b3c449d4cdc47d83af55 as build
WORKDIR /app
COPY go.* *.go .
RUN CGO_ENABLED=0 go build -a -tags netgo -ldflags '-w -extldflags "-static"' *.go
FROM scratch
COPY --from=build --chmod=777 /app/single-paparazzogo /single-paparazzogo
EXPOSE 8080
ENTRYPOINT [ "/single-paparazzogo" ] 