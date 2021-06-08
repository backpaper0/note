# Docker

## イメージを一括でpullする

```sh
docker images|tail -n +2|awk '{print $1 ":" $2}'|xargs -t -n 1 docker pull
```

## volumeの中身を確認する

```sh
docker volume ls|tail -n +2|awk '{print $2}'|xargs -I {} -t docker run --rm -v {}:/work:ro busybox find /work
```

