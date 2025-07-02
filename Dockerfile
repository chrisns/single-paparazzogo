FROM golang:1.24.4@sha256:764d7e0ce1df1e4a1bddc6d1def5f3516fdc045c5fad88e61f67fdbd1857282f as build
WORKDIR /app
COPY go.* *.go .
RUN CGO_ENABLED=0 go build -a -tags netgo -ldflags '-w -extldflags "-static"' *.go
FROM scratch
COPY --from=build --chmod=777 /app/single-paparazzogo /single-paparazzogo
EXPOSE 8080
ENTRYPOINT [ "/single-paparazzogo" ] 