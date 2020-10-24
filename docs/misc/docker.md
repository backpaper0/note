# Docker

## イメージを一括でpullする

```sh
for i in `docker images|awk '{print $1 ":" $2}'`; do echo $i; docker pull $i; done
```

## volumeの中身を確認する

```sh
for i in $(docker volume ls | tail -n +2 | awk '{print $2}'); do echo $i; docker run -it --rm -v $i:/work:ro busybox ls /work/; echo ''; done
```

