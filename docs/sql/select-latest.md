# 履歴っぽいテーブルで最新のやつだけ取ってくる

こんなテーブル。

```sql
create table history (
    keyword varchar(100)
   ,version int
   ,primary key (keyword, version)
)
```

ウィンドウ関数を使うと簡単だけど、使わないバージョンを書いておく。

```sql
select *
  from history a
 where not exists (select *
                     from history
                    where keyword = a.keyword
                      and version > a.version)
```
