# カテゴリー別に高額商品ベスト3を検索、みたいなやつ

ウィンドウ関数で抽出できる。

```sql
select a.id
     , a.price
     , a.category_id
  from (select dense_rank() over(partition by category_id order by price desc) r,
             , id
             , price
             , category_id
          from book) a
 where a.r <= 3;
```

ウィンドウ関数使えないRDBは相関サブクエリで。

```sql
select a.id
     , a.price
     , a.category_id
  from book a
 where (select count(b.id)
          from book b
         where b.price > a.price
           and b.category_id = a.category_id) < 3
```
