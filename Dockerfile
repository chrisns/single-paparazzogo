FROM golang:1.20.1@sha256:551b3e45ee4dd859b5ebea8bcc0cb1aa42d9c653c5d0e336e46830f4121134b8 as build
WORKDIR /app
COPY go.* *.go .
RUN CGO_ENABLED=0 go build -a -tags netgo -ldflags '-w -extldflags "-static"' *.go
FROM scratch
COPY --from=build --chmod=777 /app/single-paparazzogo /single-paparazzogo
EXPOSE 8080
ENTRYPOINT [ "/single-paparazzogo" ] 