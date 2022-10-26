FROM golang:1.19.2@sha256:8c64868126d0df5190eda8dfd6bf065fe9b229a5e0c707ebfdea3ac0f5e9eadf as build
WORKDIR /app
COPY go.* *.go .
RUN CGO_ENABLED=0 go build -a -tags netgo -ldflags '-w -extldflags "-static"' *.go
FROM scratch
COPY --from=build --chmod=777 /app/single-paparazzogo /single-paparazzogo
EXPOSE 8080
ENTRYPOINT [ "/single-paparazzogo" ] 