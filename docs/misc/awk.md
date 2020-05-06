# awk

簡単な使い方。
とりあえずスペースで区切って配列っぽくアクセスできる。
`$0` は全体。
`print` は文字列を繋げて出力する。
何かで区切りたかったら文字列リテラルを活用すると良さそう。

```sh
echo foo bar|awk '{print $0 "-" $1 "_" $2}'
```

### 区切り文字をスペース以外にする

`-F`を使う。

```sh
$ echo http://example.com/foo/bar | awk -F '/' '{print $4}'
foo
```

### 一番最後にマッチした文字列を取り出す

`$NF`を使う。

```sh
$ echo foo bar baz qux | awk '{print $NF}'
qux
```

### 最後からn番目にマッチした文字列を取り出す

`$(NF-n)`を使う。

```sh
$ echo foo bar baz qux | awk '{print $(NF-1)}'
baz
```
