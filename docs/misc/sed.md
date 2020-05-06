# sed

## ファイルの内容を置換する

ファイルを指定するだけ。

```sh
sed -e 's/foo/bar/g' hoge.txt
```

## 複数ファイルのリネーム

例えば `foo1.txt` `foo2.txt` `foo3.txt` を `bar1.txt` `bar2.txt` `bar3.txt` にリネームする。

```sh
for i in `ls -1|grep foo`; do mv $i `echo $i|sed -e 's/foo/bar/g'`; done
```

## シングルクォートのエスケープ

`\` でエスケープしてさらにシングルクォートで囲む。

例えばシングルクォートをダブルクォートに置換する場合は次のようにする。

```sh
sed -e 's/'\''/"/g'
```

ダブルクォートをシングルクォートにする場合も同じようにする。

```sh
sed -e 's/"/'\''/g'
```

## git grepしてマッチしたファイルを置換して上書きする

`-i` オプションでファイルを上書きできるっぽい。

```sh
git grep -l foo|xargs sed -i -e 's/foo/bar/g'
```

## build.gradleのあるディレクトリを列挙する

後から `settings.gradle` で `include` するのに便利。

```sh
find . -type f|grep build.gradle|sed 's/\.\//'\''/g'|sed 's/\/build\.gradle/'\''/g'
```

こんな感じでも良さそう（`sed`使ってない）。

```sh
find . -type f|grep build\.gradle|cut -c 3-|rev|cut -c $(echo build.gradle|wc -c)-|rev
```
