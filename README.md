# Openconnect + Tinyproxy + Dante

This Docker image contains an [openconnect client](http://www.infradead.org/openconnect/) and the [tinyproxy proxy server](https://tinyproxy.github.io/) for http/https connections (default on port 8888) and the [dante socks server](https://www.inet.no/dante/) for socks5 connections (default on port 1080) in a very small [alpine linux](https://www.alpinelinux.org/) image (around 20 MB).

## Usage

The following environment variables can be set:

	OPENCONNECT_URL=<Gateway URL>
	OPENCONNECT_USER=<Username>
	OPENCONNECT_PASSWORD=<Password>
	OPENCONNECT_MFA_CODE=<Multi-Factor authentication code>
	OPENCONNECT_OPTIONS=<Openconnect [command line options](https://www.infradead.org/openconnect/manual.html)>

If you leave `OPENCONNECT_PASSWORD` unset, you will get prompted when starting up the container.

### Example docker-run

	docker run -d \
  		--name openconnect \
  		-e OPENCONNECT_URL=vpn.example.com \
  		-e OPENCONNECT_USER=ocuser \
  		-e OPENCONNECT_PASSWORD="ocpassword \
  		-e OPENCONNECT_MFA_CODE=ocmfacode \
  		-e OPENCONNECT_OPTIONS="--timestamp --verbose" \
  		-p 1080:1080 \
  		-p 8888:8888 \
  		--privileged \
  		cavemandaveman/openconnect:latest

### Example docker-compose

See [docker-compose.yml](docker-compose.yml)

### Recommended clients

Web browser:
- [FoxyProxy](https://getfoxyproxy.org)

CLI:
- [proxychains](https://github.com/haad/proxychains)

### Build

You can build the container yourself with

	docker build -t cavemandaveman/openconnect:custom .
