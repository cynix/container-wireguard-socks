#!/bin/sh -e

if [ "$(cat /proc/sys/net/ipv4/conf/all/src_valid_mark)" != "1" ]; then
    echo 'sysctl net.ipv4.conf.all.src_valid_mark=1 not set' >&2
    exit 1
fi

ext_if=$(basename "$(find /etc/wireguard/ -name '*.conf' | head -n1)" .conf)
sed -i'' -e "s/EXT_IF/$ext_if/" /etc/sockd.conf

/usr/bin/wg-quick up /etc/wireguard/$ext_if.conf
/usr/sbin/sockd
