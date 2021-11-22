FROM docker.io/library/alpine:latest

RUN apk add --no-cache dante-server wireguard-tools
RUN sed -i"" -e "s/sysctl -q net.ipv4.conf.all.src_valid_mark=1/true/" /usr/bin/wg-quick

COPY etc/sockd.conf /etc/
COPY bin/entrypoint.sh /bin/

ENTRYPOINT ["/bin/entrypoint.sh"]
