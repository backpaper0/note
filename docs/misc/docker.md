# Docker

## イメージを一括でpullする

```sh
for i in `docker images|awk '{print $1 ":" $2}'`; do echo $i; docker pull $i; done
```
