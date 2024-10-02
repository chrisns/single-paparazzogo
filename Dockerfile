FROM golang:1.23.2@sha256:adee809c2d0009a4199a11a1b2618990b244c6515149fe609e2788ddf164bd10 as build
WORKDIR /app
COPY go.* *.go .
RUN CGO_ENABLED=0 go build -a -tags netgo -ldflags '-w -extldflags "-static"' *.go
FROM scratch
COPY --from=build --chmod=777 /app/single-paparazzogo /single-paparazzogo
EXPOSE 8080
ENTRYPOINT [ "/single-paparazzogo" ] 