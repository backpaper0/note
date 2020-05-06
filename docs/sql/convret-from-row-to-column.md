# 縦を横にする

縦を横にするには `case` と集合関数を使うと良い。

例えば次のようなテーブルがあったとする。

```sql
CREATE TABLE Hoge (
    id INT PRIMARY KEY
   ,col VARCHAR(100)
);

INSERT INTO Hoge VALUES (1, 'aaa');
INSERT INTO Hoge VALUES (2, 'bbb');
INSERT INTO Hoge VALUES (3, 'ccc');
```

これを、
`id` が `1` のものを1つめのカラム、
`id` が `2` のものを2つめのカラム、
`id` が `3` のものを3つめのカラムにする。

まず `case` を使ってみる。

```sql
SELECT
    CASE id WHEN 1 THEN col ELSE NULL END AS col1
   ,CASE id WHEN 2 THEN col ELSE NULL END AS col2
   ,CASE id WHEN 3 THEN col ELSE NULL END AS col3
FROM Hoge
```

これで次のような結果を得られる。

|col1|col2|col3|
|---|---|---|
|aaa|NULL|NULL|
|NULL|bbb|NULL|
|NULL|NULL|ccc|

あとは集合関数( `MAX` 関数)で1行にまとめればOK。
完全なクエリは次のようになる。

```sql
SELECT
    MAX(CASE id WHEN 1 THEN col ELSE NULL END) AS col1
   ,MAX(CASE id WHEN 2 THEN col ELSE NULL END) AS col2
   ,MAX(CASE id WHEN 3 THEN col ELSE NULL END) AS col3
FROM Hoge
```

次のような結果を得られて、縦を横に持つ事ができた。

|col1|col2|col3|
|---|---|---|
|aaa|bbb|ccc| 
