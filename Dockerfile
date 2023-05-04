FROM golang:1.20.4@sha256:6876eff5b20336c5c2896b0c3055f3258bdeba7aa38bbdabcb5a4abb5cdd39c7 as build
WORKDIR /app
COPY go.* *.go .
RUN CGO_ENABLED=0 go build -a -tags netgo -ldflags '-w -extldflags "-static"' *.go
FROM scratch
COPY --from=build --chmod=777 /app/single-paparazzogo /single-paparazzogo
EXPOSE 8080
ENTRYPOINT [ "/single-paparazzogo" ] 