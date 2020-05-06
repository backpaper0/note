# PostgreSQL

## インストールからREPLでの接続まで

データベースクラスタの初期化や、データベースサーバ起動・停止は [pg\_ctl](https://www.postgresql.jp/document/current/html/app-pg-ctl.html) でできる。

```sh
# データベースクラスタの初期化
echo password>/path/to/pwfile
initdb -D /path/to/data_dir -U postgres --pwfile=/path/to/pwfile
# データベースサーバの起動
pg_ctl start -D /path/to/data_dir -l /path/to/logfile
# データベースサーバの停止
pg_ctl stop -D /path/to/data_dir -m smart
```

データベースサーバが起動しているかどうかは、データディレクトリ内に `postmaster.pid` があるかどうかで判断できる。

データベースサーバが起動したらユーザーとデータベースを作る。

```sh
# ユーザーを作成する（postgresユーザーで接続してfooユーザーを作る）
createuser foo -P -U postgres
# データベースを作成する（オーナーはfoo、このコマンドを実行するのはpostgres）
createdb foodb -O foo -U postgres --locale=C --encoding=UTF-8 --template=template0
```

作ったデータベースへ、とりあえず `psql` で接続する。

```sh
# fooユーザーで接続する
psql foodb -U foo
```

データベース・ユーザーを削除する場合は次の通り。

```sh
dropdb foodb -U postgres
dropuser foo -U postgres
```

## Dockerでポスグレを立てる

```sh
docker run -d -p 5432:5432 --name=mypostgres postgres
```

デフォルトだとDatabase Name、Username、Passwordは全てpostgresになる。

## Tips

### ユーザー（ロール）の一覧

```sh
psql -U postgres -c "\du"
```
