# Note

うらがみのノート。

MkDocsを使っている。

ノートを書くときはサーバーを立てて書くとリアルタイムに反映された画面を見られるので良い。

```
docker run -d --name note -p 8000:8000 --mount type=bind,source="$(PWD)",target=/docs squidfunk/mkdocs-material
```

どこかのサーバーに置く場合はビルドすれば良い。

```
docker run --rm --mount type=bind,source="$(pwd)",target=/docs squidfunk/mkdocs-material build
```

