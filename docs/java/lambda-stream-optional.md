# Javaのラムダ式とStream-API、Optional

## Optional&lt;Optional&lt;T&gt;&gt; を Optional&lt;T&gt; に変換する

```java
Optional<Optional<T>> src = ...

Optional<T> dest = src.flatMap(opt -> opt);
//もしくは
Optional<T> dest = src.flatMap(Function.identity());
```

## List&lt;Optional&lt;T&gt;&gt; を List&lt;T&gt; に( Optional.empty() を除きつつ)変換する

```java
List<Optional<T>> src = ...

//Example 1
List<T> dest = src.stream().flatMap(opt -> opt.map(Stream::of).orElseGet(Stream::empty)).collect(Collectors.toList());

//Example 2
List<T> dest = src.stream().filter(Optional::isPresent).map(Optional::get).collect(Collectors.toList());
```

## AがダメならB、BがダメならC、という感じのやつ

こんな感じでA、B、Cを試すメソッドがあるとして、

```java
Optional<T> tryA() { ... }
Optional<T> tryB() { ... }
Optional<T> tryC() { ... }
```

こんな感じのコードで順番に試して成功したらその値を返せる。

```java
tryA()
.map(Optional::of).orElseGet(this::tryB)
.map(Optional::of).orElseGet(this::tryC)
.orElse(defaultValue);
```

`Stream` でも出来るけど `Supplier` が推論できないのが残念。

```java
Stream.<Supplier<Optional<T>>> of(
    this::tryA, this::tryB, this::tryC)
    .map(Supplier::get)
    .filter(Optional::isPresent)
    .map(Optional::get)
    .findFirst()
    .orElse(defaultValue);
```

## ラムダ式で再帰する

普通にやると再帰できないので補助的な関数をかます。

```java
RecursiveFunction<Integer, Integer> preSum = (f, p) -> p < 1 ? 0 : p + f.apply(f, p - 1);
Function<Integer, Integer> sum = preSum.toRecursion();
Integer result = sum.apply(10);
System.out.println(result); //55
```

```java
public interface RecursiveFunction<P, R> extends BiFunction<RecursiveFunction<P, R>, P, R> {

    default Function<P, R> toRecursion() {
        return p -> apply(this, p);
    }
}
```
