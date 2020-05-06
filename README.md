# Note

```
docker build -t mkdocs docker
```

```
docker run --rm --mount type=bind,source="$(pwd)",target=/workspace mkdocs new .
```

```
docker run -d --name note -p 8000:8000 --mount type=bind,source="$(pwd)",target=/workspace mkdocs
```

```
docker run --rm --mount type=bind,source="$(pwd)",target=/workspace mkdocs build
```

