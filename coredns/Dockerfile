FROM golang:1.22 AS builder

# Install required tools
RUN apt-get update && apt-get install -y git

# Clone CoreDNS
WORKDIR /src
RUN git clone https://github.com/coredns/coredns.git

# Clone the docker plugin
RUN git clone https://github.com/kevinjqiu/coredns-dockerdiscovery.git

WORKDIR /src/coredns

# Copy our custom plugin.cfg
COPY plugin.cfg plugin.cfg

# Build CoreDNS with our plugins
RUN go get github.com/kevinjqiu/coredns-dockerdiscovery
RUN go generate
RUN go build

# Final stage
FROM debian:bookworm-slim

COPY --from=builder /src/coredns/coredns /coredns

EXPOSE 53 53/udp
ENTRYPOINT ["/coredns"]
