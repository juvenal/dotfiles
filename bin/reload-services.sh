#!/bin/bash

ssh root@openwrt-border.v2-labs.io "/etc/init.d/pppoe-server enable; /etc/init.d/pppoe-server start" && \
    echo "OpenWRT Border - PPPoE Server enabled and up..."
ssh root@openwrt-border.v2-labs.io "/etc/init.d/collectd reload" && \
    echo "OpenWRT Border collectd reloaded..."
ssh root@openwrt01.v2-labs.io "/etc/init.d/collectd reload" && \
    echo "OpenWRT 01 - collectd reloaded..."
ssh root@openwrt02.v2-labs.io "/etc/init.d/collectd reload" && \
    echo "OpenWRT 02 - collectd reloaded..."
ssh root@openwrt03.v2-labs.io "/etc/init.d/collectd reload" && \
    echo "OpenWRT 03 - collectd reloaded..."
