FROM golang:1.22.4@sha256:0f7691253e132744318ff4b02e0824fec9fa4f3b43b08afd1195599660d51521 as build
WORKDIR /app
COPY go.* *.go .
RUN CGO_ENABLED=0 go build -a -tags netgo -ldflags '-w -extldflags "-static"' *.go
FROM scratch
COPY --from=build --chmod=777 /app/single-paparazzogo /single-paparazzogo
EXPOSE 8080
ENTRYPOINT [ "/single-paparazzogo" ] 