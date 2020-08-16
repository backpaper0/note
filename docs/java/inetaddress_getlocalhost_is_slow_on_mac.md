# Macだとjava.net.InetAddress.getLocalHostが遅い

Sierra以降で発生するっぽい。

```
$ echo "InetAddress.getLocalHost()" | time jshell -s       
-> InetAddress.getLocalHost()
-> jshell -s  3.31s user 0.25s system 54% cpu 6.582 total
```

遅い、、、

## 解決策1

`hosts`ファイルを指定してあげる。

まず`/etc/hosts`をコピーして自分のホスト名がループバックアドレスを指すようにする。
自分のホスト名は`uname -n`で確認できる。

```
##
# Host Database
#
# localhost is used to configure the loopback interface
# when the system is booting.  Do not change this entry.
##
127.0.0.1	localhost
255.255.255.255	broadcasthost
::1             localhost

127.0.0.1	yourhostname.local
```

そしてシステムプロパティ`jdk.net.hosts.file`で`hosts`ファイルを指定する。

```
$ echo "InetAddress.getLocalHost()" | time jshell -s -R-Djdk.net.hosts.file=./hosts
-> InetAddress.getLocalHost()
-> jshell -s -R-Djdk.net.hosts.file=./hosts  2.87s user 0.24s system 199% cpu 1.562 total
```

今回は`/etc/hosts`をコピーしたけど、もちろん直接編集しても良い。

## 解決策2

WIP `scutil`を使う。

