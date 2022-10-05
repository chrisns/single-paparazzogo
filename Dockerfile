FROM golang:1.19.2@sha256:c2a98a509c3d901aed78332fa0bf6144b4f9ac2bceff2bc77ddc6bc3b70276a5 as build
WORKDIR /app
COPY go.* *.go .
RUN CGO_ENABLED=0 go build -a -tags netgo -ldflags '-w -extldflags "-static"' *.go
FROM scratch
COPY --from=build --chmod=777 /app/single-paparazzogo /single-paparazzogo
EXPOSE 8080
ENTRYPOINT [ "/single-paparazzogo" ] 