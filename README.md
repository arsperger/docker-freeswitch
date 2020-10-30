# About

FreeSWITCH minimized docker image

Minimized Freeswitch container build `FROM scratch` using script: `script/make_min_archive.sh` from [FreeSWITCH Repo](https://github.com/signalwire/freeswitch/blob/f6c10f8622e997548a486e5bf4f700b37e12a4eb/docker/base_image/README.md)

Size of container is ~57MB

Container has pre-built `mod_bcg729` loaded at start-up.
Minimal Freeswitch configuration with default password changed.
sngrep installed.
suitable for various VoIP testing scenarios in docker/compose/swarm environments and microservices

To create your custome minimal image clone the repo and change `script/make_min_archive.sh` then run `make`
this will build a debian image with `freeswitch_img.tar.gz` tarball in `/usr/local/src` folder,
cp the archive to the root of repo and run `docker build -t freeswitch:latest .`

Installed modules:

- freeswitch-mod-console
- freeswitch-mod-sofia
- freeswitch-mod-commands
- freeswitch-mod-json-cdr
- freeswitch-mod-db
- freeswitch-mod-dptools
- freeswitch-mod-hash
- freeswitch-mod-dialplan-xml
- freeswitch-mod-sndfile
- freeswitch-mod-native-file
- freeswitch-mod-tone-stream
- freeswitch-mod-say-en
- freeswitch-mod-event-socket
- freeswitch-mod-loopback
- freeswitch-mod-xml-curl
- freeswitch-mod-expr
- freeswitch-mod-httapi
- freeswitch-mod-local-stream
- freeswitch-mod-spandsp
- freeswitch-mod-g723-1
- freeswitch-mod-opus

## Usage

Run container with host network:

```sh
docker run --net=host --name freeswitch arsperger/freeswitch:latest
```

Run container with bridge network:

```sh
docker run --rm -p 5060:5060/udp -p 5060:5060 --name freeswitch arsperger/freeswitch:latest
```

Connect to freeswitch via CLI

```sh
docker exec -it freeswitch /usr/bin/fs_cli
```

Run sngrep

```sh
docker exec -it freeswitch sngrep -d any
```

## Docker-compose

```sh
make test
```

@arsperger