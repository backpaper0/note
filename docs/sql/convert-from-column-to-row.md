# 横を縦にする

横、つまり1レコードで複数のカラムに持っている値を、縦、つまり複数レコードに分解するには `UNION` を使う。

例えば、次のようなテーブルがあるとする。

```sql
CREATE TABLE Hoge (
    id INT PRIMARY KEY
   ,col1 VARCHAR(100)
   ,col2 VARCHAR(100)
   ,col3 VARCHAR(100)
);

INSERT INTO Hoge VALUES (1, 'aaa', 'bbb', 'ccc');
```

この時、次のようなクエリで横を縦にできる。

```sql
SELECT col1 AS col FROM Hoge WHERE id = 1
UNION ALL
SELECT col2 AS col FROM Hoge WHERE id = 1
UNION ALL
SELECT col3 AS col FROM Hoge WHERE id = 1
```

場合によってはCTEを使えば加工しやすくなる。

```sql
WITH x AS (SELECT * FROM Hoge WHERE id = 1),
     y AS (SELECT col1 AS col FROM x
           UNION ALL
           SELECT col2 AS col FROM x
           UNION ALL
           SELECT col3 AS col FROM x)
SELECT col FROM y
```
