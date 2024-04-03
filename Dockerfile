FROM golang:1.22.2@sha256:c4fb952e712efd8f787bcd8e53fd66d1d83b7dc26adabc218e9eac1dbf776bdf as build
WORKDIR /app
COPY go.* *.go .
RUN CGO_ENABLED=0 go build -a -tags netgo -ldflags '-w -extldflags "-static"' *.go
FROM scratch
COPY --from=build --chmod=777 /app/single-paparazzogo /single-paparazzogo
EXPOSE 8080
ENTRYPOINT [ "/single-paparazzogo" ] 