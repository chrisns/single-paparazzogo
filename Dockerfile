FROM golang:1.19.5@sha256:cf841ab79240b8ce58e9a3e4bcaf0b7a40ee9feb7dc6824a75f344b6f8886d43 as build
WORKDIR /app
COPY go.* *.go .
RUN CGO_ENABLED=0 go build -a -tags netgo -ldflags '-w -extldflags "-static"' *.go
FROM scratch
COPY --from=build --chmod=777 /app/single-paparazzogo /single-paparazzogo
EXPOSE 8080
ENTRYPOINT [ "/single-paparazzogo" ] 