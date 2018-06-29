FROM hypriot/rpi-alpine:3.6
MAINTAINER sgelmi

RUN apk add --update openssl ipsec-tools iptables shadow \
	&& rm -rf /var/cache/apk/*

#Copy racoon config
COPY racoon.conf /etc/racoon.conf

# Create scripts to manage VPN service
COPY local.conf /etc/sysctl.d/

COPY init users /usr/local/bin/
RUN chmod +x /usr/local/bin/*
RUN mkdir /etc/racoon
RUN touch /etc/racoon/psk.txt

VOLUME /mnt

EXPOSE 500/udp 4500/udp

# Start VPN service
ENTRYPOINT ["/usr/local/bin/init"]
