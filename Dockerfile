FROM alpine:3.18
VOLUME [ "/data" ]

# Use a reduced set of ca certificates to simulate an old ca-certificates.crt file
COPY ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

WORKDIR /data
ENTRYPOINT [ "/bin/sleep", "infinity" ]