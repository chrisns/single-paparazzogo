FROM golang:1.19.4@sha256:cfaad8202aed5121121dfe3a252e98d5c89cc67fc456cc69fe70eb7dcc1b8cff as build
WORKDIR /app
COPY go.* *.go .
RUN CGO_ENABLED=0 go build -a -tags netgo -ldflags '-w -extldflags "-static"' *.go
FROM scratch
COPY --from=build --chmod=777 /app/single-paparazzogo /single-paparazzogo
EXPOSE 8080
ENTRYPOINT [ "/single-paparazzogo" ] 