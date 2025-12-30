FROM golang:1.25.5@sha256:6396b3d8039d2050ab7a3c5c6e1cbeed8bf6d2ddc0403e1ab39d78749227ca19 as build
WORKDIR /app
COPY go.* *.go .
RUN CGO_ENABLED=0 go build -a -tags netgo -ldflags '-w -extldflags "-static"' *.go
FROM scratch
COPY --from=build --chmod=777 /app/single-paparazzogo /single-paparazzogo
EXPOSE 8080
ENTRYPOINT [ "/single-paparazzogo" ] 