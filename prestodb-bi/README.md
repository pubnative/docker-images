# PrestoDB for BI tool

See PrestoDB docker image docs.

Build with `--build-arg CACHEBUST=1` to force rebuild with --no-cache from a specific step (here after presto download).

Eg.
```docker build -t pubnative/prestodb:bi-0.157 --build-arg CACHEBUST=1```
