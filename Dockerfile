FROM golang:bullseye as builder

WORKDIR /src

COPY . .

ENV CGO_ENABLED=0

RUN go build -ldflags '-w -s' -o /usr/bin/waveplus .

FROM debian:bullseye

COPY --from=builder /usr/bin/waveplus /usr/bin/waveplus
COPY --from=builder /src/entrypoint.sh /entrypoint.sh

RUN apt-get update && apt-get install -y \
    bluez \
    dbus \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT sh /entrypoint.sh

CMD ["/usr/bin/waveplus"]
