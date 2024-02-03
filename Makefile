all: _gokrazy/extrafiles_arm64.tar _gokrazy/extrafiles_amd64.tar

_gokrazy/extrafiles_arm64.tar: Dockerfile
	docker build --rm -t dnsmasq .
	docker run --rm -v $$(pwd)/_gokrazy/:/tmp/gokrazy/:Z dnsmasq sh -c 'mkdir -p /tmp/extrafiles/usr/lib/aarch64-linux-gnu/dnsmasq.frozen && mkdir -p /tmp/extrafiles/lib && mkdir -p /tmp/extrafiles/usr/local/bin && mkdir -p /tmp/extrafiles/usr/lib/aarch64-linux-gnu/ && tar xf /tmp/freeze/freeze*.tar -C /tmp/extrafiles/usr/lib/aarch64-linux-gnu/dnsmasq.frozen --strip-components=1 && chown -R 1000:1000 /tmp/extrafiles && ln -sf /user/dnsmasq /tmp/extrafiles/usr/local/bin/dnsmasq && cd /tmp/extrafiles && tar cf /tmp/gokrazy/extrafiles_arm64.tar *'

_gokrazy/extrafiles_amd64.tar: Dockerfile.amd64
	docker build --rm -t dnsmasq --file Dockerfile.amd64 .
	docker run --rm -v $$(pwd)/_gokrazy/:/tmp/gokrazy/:Z dnsmasq sh -c 'mkdir -p /tmp/extrafiles/usr/lib/x86_64-linux-gnu/dnsmasq.frozen && mkdir -p /tmp/extrafiles/lib && mkdir -p /tmp/extrafiles/usr/local/bin && mkdir -p /tmp/extrafiles/usr/lib/x86_64-linux-gnu/ && tar xf /tmp/freeze/freeze*.tar -C /tmp/extrafiles/usr/lib/x86_64-linux-gnu/dnsmasq.frozen --strip-components=1 && chown -R 1000:1000 /tmp/extrafiles && ln -sf /user/dnsmasq /tmp/extrafiles/usr/local/bin/dnsmasq && cd /tmp/extrafiles && tar cf /tmp/gokrazy/extrafiles_amd64.tar *'

clean:
	rm -f _gokrazy/extrafiles_*.tar
