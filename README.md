# Note

うらがみのノート。

MkDocsを使っている。

Dockerで見られるようにしている。

まずはコンテナイメージをビルドする。

```
docker build -t mkdocs docker
```

次にサーバーを立てる。
ノートを書くときはサーバーを立てて書くとリアルタイムに反映された画面を見られるので良い。

```
docker run -d --name note -p 8000:8000 --mount type=bind,source="$(pwd)",target=/workspace mkdocs
```

どこかのサーバーに置く場合はビルドすれば良い。

```
docker run --rm --mount type=bind,source="$(pwd)",target=/workspace mkdocs build
```

