FROM alpine:3.22.1

RUN apk add --no-cache tcpdump wireguard-tools

COPY entrypoint.sh /usr/local/bin/vad-vpn
RUN chmod 0755 /usr/local/bin/vad-vpn

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wg show wg0 >/dev/null || exit 1

ENTRYPOINT ["/usr/local/bin/vad-vpn"]
