# Turnilo

Image containing [Turnilo][1] (a Druid frontebd). Images are published to `us-docker.pkg.dev/vgi-pn-277619/data-team/pubnative/turnilo`

## Build

Set the version to build within the `Makefile` file, and then:

```bash
make build
```

## Push

```bash
make push
```

## Both

```bash
make all
```

[1]: https://github.com/allegro/turnilo
