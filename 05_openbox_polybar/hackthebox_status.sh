#!/bin/sh


IFACE=$(/usr/sbin/ifconfig | grep tun0 | awk '{print $1}' | tr -d ':')

if [ -z "$IFACE" ]; then
	IFACE=$(/usr/sbin/ifconfig | grep tap0 | awk '{print $1}' | tr -d ':')
fi

if [ "$IFACE" = "tun0" ]; then
    echo "%{F#1bbf3e} %{F#ffffff}$(/usr/sbin/ifconfig tun0 | grep "inet " | awk '{print $2}')%{u-}"
elif [ "$IFACE" = "tap0" ]; then
	echo "%{F#1bbf3e}輦 %{F#ffffff}$(/usr/sbin/ifconfig tap0 2>/dev/null | grep 'inet ' | awk '{print $2}')%{u-}"
else
    echo "%{F#1bbf3e}%{u-} Disconnected"
fi
