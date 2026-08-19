# VAD team VPN image

This repository publishes the WireGuard attachment used by generated VAD team
bundles. The image contains `wireguard-tools` and `tcpdump`; each bundle mounts
its generated configuration at `/etc/wireguard/wg0.conf`.

Published image:

```text
ghcr.io/vidner/vad-vpn:latest
```

## Publish

Push to `main` or manually run the **Publish VPN image** workflow. It publishes
multi-architecture `linux/amd64` and `linux/arm64` images with two tags:

- `latest`, consumed by VAD-generated bundles;
- `sha-<full-commit-sha>`, retained as an immutable release reference.

The workflow authenticates to GHCR with GitHub's short-lived `GITHUB_TOKEN`; no
personal access token is required. After the first publish, set the
`vidner/vad-vpn` package visibility to **public** so team servers can pull it
without registry credentials.

## Run manually

The generated team bundle supplies the required capabilities, TUN device, and
configuration mount. The equivalent standalone invocation is:

```sh
docker run --rm \
  --cap-add NET_ADMIN \
  --device /dev/net/tun:/dev/net/tun \
  --sysctl net.ipv4.ip_forward=1 \
  --mount type=bind,src="$PWD/wg0.conf",dst=/etc/wireguard/wg0.conf,readonly \
  ghcr.io/vidner/vad-vpn:latest
```
