# シェルスクリプト

Mac固有の話とかもあるかも。

## findでファイルだけを対象にする

`-type` オプションを使う。

```sh
find . -type f
```

`f` なら通常のファイル。

## ファイルの行数をカウントする

```sh
wc -l
```

## 拡張子を一括で変更する

`.txt` を `.md` に変更する。

```sh
for x in *.txt; do mv $x ${x%.txt}.md; done
```

## 文字コード変換する

`hoge.txt` の文字コードを Shift\_JIS から UTF-8 に変換する。

```sh
iconv -f Shift_JIS -t UTF-8 hoge.txt 
```

## .tar.gzなファイルを解凍する

```sh
tar zxvf hoge.tar.gz
```

オプションの意味。

- `z` ... 自動でgzip圧縮されているか認識してくれる
- `x` ... 解凍する。同じ名前のファイルがあったら後勝ちで上書きされる。
- `v` ... 詳細なログを出す
- `f` ... アーカイブファイルを指定する

## .tar.gzなファイルを作成する

```sh
tar zcvf hoge.tar.gz dir
```

オプションの意味。

- `z` ... gzip圧縮する
- `c` ... 新しいアーカイブを作成する
- `v` ... 詳細なログを出す
- `f` ... アーカイブファイルを指定する

## ZIPファイルを作る

```sh
zip -r hoge.zip dir
```

## ディレクトリ内のファイルのサイズ合計を確認する

```sh
du -sh target-directory
```

## 鍵ファイルとポートを指定してSSHで繋ぐ

```sh
ssh -i /path/to/id_rsa -p 8022 -l username hostname.com
```

## 鍵ファイルとポートを指定してscp……ではなくrsyncでファイルを送る

```sh
rsync -avz -e "ssh -i /path/to/id_rsa -p 8022" /path/to/local/file username@hostname.com:/path/to/remote/file
scp -i /path/to/id_rsa -P 8022 /path/to/local/file username@hostname.com:/path/to/remote/file
```

`~/.ssh/config`にホストの設定があればもっと楽。

```
# ~/.ssh/config
Host example
	HostName hostname.com
    Port 8022
	User username
    IdentityFile /path/to/id_rsa
    ServerAliveInterval 60
```

```sh
rsync -avz /path/to/local/file example:/path/to/remote/file
```

`P`オプションで進行状況を見ることもできる。

```sh
rsync -avzP example:/path/to/remote/file /path/to/local/file
```

## 再起動した日時を調べる

ログインしたときを調べるlastコマンドでrebootというユーザーを調べたら分かるっぽい。

```sh
last reboot
```

## プロセスを確認して落とす

プロセスの一覧を確認する。

```sh
ps aux
```

- `a` ... 自分以外のユーザーのプロセスも表示する
- `u` ... ユーザー名を表示する
- `x` ... ターミナル外のプロセスも表示する

一覧でPIDを確認したらそれをもってプロセスを落とす。

```sh
kill -9 <PID>
```

## CentOSでOSのバージョンを確認する

```sh
cat /etc/redhat-release
```

## Javaアプリケーションをサービス化する

`java` コマンドはフォアグラウンドで実行されるので後ろに `&` を付けてバックグラウンドで実行するようにする。

また、その際に標準出力・エラー出力をコンソールに出したくないので `> /dev/null 2>&1` という風にリダイレクトする。

停止するときは `kill` コマンドを使う。
プロセスIDは `pgrep` コマンドで解決している。

```sh
#!/bin/bash

COMMANDLINE="java -jar /opt/hoge/app.jar"

start() {
    if [ "`pgrep -f "$COMMANDLINE"`" = "" ]; then
        $COMMANDLINE > /dev/null 2>&1 &
    fi
}

stop() {
    if [ "`pgrep -f "$COMMANDLINE"`" != "" ]; then
        kill -9 `pgrep -f "$COMMANDLINE"`
    fi
}

restart() {
    stop
    start
}

case "$1" in
    start)   start   ;;
    stop)    stop    ;;
    restart) restart ;;
    *) echo "usage: $0 (start|stop|restart)"
esac
```

## セットアップするときに使いそうなやつ

ログイン中のユーザーを確認する

```sh
whoami
```

ユーザーを追加する

```sh
useradd
```

パスワードを変更する

```sh
passwd
```

ユーザー一覧を見る。ホームディレクトリも確認できる。

```sh
cat /etc/passwd
```

タイムゾーンの確認

```sh
date
```

タイムゾーンの変更

```sh
ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
```

<!-- TODO `timedatectl` 調べる -->

## どのプログラムがポートを使用しているか確認する

```sh
netstat -atunp|grep 8080
```

## 使用しているポートの確認

```sh
lsof -i -P
```

## JDKの場所を探す

```sh
rpm -lq java-1.8.0-openjdk
alternatives --config java
```

## カレントディレクトリ以下の容量を確認する

```sh
du -hs
```

オプションについて。

- `-h` ... 読みやすい形式にしてくれる
- `-s` ... すべてのファイルのサイズをまとめてくれる

## 0から100まで出力する

```sh
echo {0..100}
```

`echo` 以外でも使えるし、便利。

## ソート済みのファイルから重複を除く

ソート済みでないといけない。

```sh
uniq sorted_file.txt
```

## ディレクトリを再帰的に辿ってgrepする

```sh
grep -r query .
```

## 先頭10行を取得、末尾10行を取得、先頭10行以降を取得

```
head -n 10
```

```
tail -n 10
```

```
tail -n +10
```
