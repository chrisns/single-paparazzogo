FROM golang:1.17.6@sha256:2adfd0d7f507cfe0dab9aefaf3e0b973b9c8cce48caa43431dca7f8a2cef5557 as build
WORKDIR /app
COPY go.* *.go .
RUN CGO_ENABLED=0 go build -a -tags netgo -ldflags '-w -extldflags "-static"' *.go
FROM scratch
COPY --from=build --chmod=777 /app/single-paparazzogo /single-paparazzogo
EXPOSE 8080
ENTRYPOINT [ "/single-paparazzogo" ] 