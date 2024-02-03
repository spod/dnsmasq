## dnsmasq for gokrazy

This package is a [frozen](https://github.com/gokrazy/freeze) version of
`dnsmasq`, coming from [Debian
“trixie” (currently testing)](https://www.debian.org/releases/trixie/).

This package is to support playing with [dnsmasq](https://thekelleys.org.uk/dnsmasq/doc.html) using gokrazy breakglass.

This package is based on [gokrazy/iptables](https://github.com/gokrazy/iptables).

### Note to self
Run in breakglass mode without detaching and mostly default config:
```shell
/tmp/breakglass3551552720 # /user/dnsmasq  -u '' -d -x /tmp/dnsmasq.pid
dnsmasq: started, version 2.89 cachesize 150
dnsmasq: compile time options: IPv6 GNU-getopt DBus no-UBus i18n IDN2 DHCP DHCPv6 no-Lua TFTP conntrack ipset nftset auth cryptohash DNSSEC loop-detect inotify dumpfile
...
```

(-u '' is necessary as there are no users/groups in gokrazy and dnsmasq tries to drop privileges)
