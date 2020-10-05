# jq

- https://stedolan.github.io/jq/

## 大きなJSONで、ある値がどのパスにあるのか調べる

このあたりを使う。

- [..](https://stedolan.github.io/jq/manual/#RecursiveDescent:..)
- [?](https://stedolan.github.io/jq/manual/#OptionalObjectIdentifier-Index:.foo?)
- [select](https://stedolan.github.io/jq/manual/#select(boolean_expression))
- [path](https://stedolan.github.io/jq/manual/#path(path_expression))

例えば`docker inspect`で得たJSONの中から、exposeしたポートのマッピング先ポートを得るには、どのパスの値を取ればいいのかを調べる。

```
$ container_id=$(docker run -d -P nginx)
$ docker inspect $container_id | jq 'path(.. | .HostPort? | select(. != null))'
[
  0,
  "NetworkSettings",
  "Ports",
  "80/tcp",
  0,
  "HostPort"
]
$ % docker inspect $container_id | jq -r '.[0].NetworkSettings.Ports."80/tcp"[0].HostPort'
32779
```

まず`..`で再帰的にすべてのパスを書き出す。

```
$ echo '{"a":{"b":{"c":"hello"}}}' | jq '..'
{
  "a": {
    "b": {
      "c": "hello"
    }
  }
}
{
  "b": {
    "c": "hello"
  }
}
{
  "c": "hello"
}
"hello"
```

次に目的のキーを取り出す。
このとき該当するキーがない場合はエラーとなってしまうため`?`を使う。

```
$ echo '{"a":{"b":{"c":"hello"}}}' | jq '.. | .c?'
null
null
"hello"
```

`?`を付けない場合はこうなる。

```
$ echo '{"a":{"b":{"c":"hello"}}}' | jq '.. | .c' 
null
null
"hello"
jq: error (at <stdin>:1): Cannot index string with string "c"
```

それから`select`で`null`でないものだけを取り出す。

```
$ echo '{"a":{"b":{"c":"hello"}}}' | jq '.. | .c? | select(. != null)'
"hello"
```

最後に`path`でパスを取得する。

```
$ echo '{"a":{"b":{"c":"hello"}}}' | jq 'path(.. | .c? | select(. != null))'
[
  "a",
  "b",
  "c"
]
```

別解。
[type](https://stedolan.github.io/jq/manual/#type)と[has](https://stedolan.github.io/jq/manual/#has(key))を使う。

```
$ docker inspect $container_id | jq 'path(.. | select(type == "object" and has("HostPort")) | .HostPort)'
[
  0,
  "NetworkSettings",
  "Ports",
  "80/tcp",
  0,
  "HostPort"
]
```

ちなみにこの例で単にNginxコンテナのポート`80`がどのポートにマッピングされているかを取るだけならこれで良かった。

```
$ docker inspect $container_id | jq -r '.. | select(type == "object" and has("HostPort")) | .HostPort'
32779
```

## 日時関連

### Fri Jul 20 03:20:02 +0000 2018のような日時をパースする。

```
echo '"Fri Jul 20 03:20:02 +0000 2018"' | jq 'strptime("%a %b %d %H:%M:%S %z %Y")|mktime'
```

[Pythonのstrptime](https://docs.python.org/ja/3/library/datetime.html#strftime-and-strptime-format-codes)の書式をサポートしているのかな？
