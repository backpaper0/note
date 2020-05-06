# Java-7と8でコンパイル結果が異なる

次のようなクラスがあるとする。

```java
public class Hoge {

    void run() {
        String.valueOf(get());
    }

    <T> T get() {
        return null;
    }
}
```

これをJava 7でコンパイルして`javap`してみる。

```sh
docker run --rm -v `pwd`:/work openjdk:7 javac /work/Hoge.java
javap -v Hoge
```

`run`メソッドを見ると`String.valueOf(Object)`が呼び出されていることがわかる。

```
  void run();
    descriptor: ()V
    flags: (0x0000)
    Code:
      stack=1, locals=1, args_size=1
         0: aload_0
         1: invokevirtual #2                  // Method get:()Ljava/lang/Object;
         4: invokestatic  #3                  // Method java/lang/String.valueOf:(Ljava/lang/Object;)Ljava/lang/String;
         7: pop
         8: return
      LineNumberTable:
        line 4: 0
        line 5: 8
```

次にJava 8でコンパイルして`javap`してみる。

```sh
docker run --rm -v `pwd`:/work openjdk:8 javac /work/Hoge.java
javap -v Hoge
```

`String.valueOf(char[])`が呼び出されていることがわかる。

```
  void run();
    descriptor: ()V
    flags: (0x0000)
    Code:
      stack=1, locals=1, args_size=1
         0: aload_0
         1: invokevirtual #2                  // Method get:()Ljava/lang/Object;
         4: checkcast     #3                  // class "[C"
         7: invokestatic  #4                  // Method java/lang/String.valueOf:([C)Ljava/lang/String;
        10: pop
        11: return
      LineNumberTable:
        line 4: 0
        line 5: 11
```

`String.valueOf`のオーバーロードは次の通り。

- `valueOf(boolean b)`
- `valueOf(char c)`
- `valueOf(char[] data)`
- `valueOf(char[] data, int offset, int count)`
- `valueOf(double d)`
- `valueOf(float f)`
- `valueOf(int i)`
- `valueOf(long l)`
- `valueOf(Object obj)`

これらのうち1引数を取り、それが非プリミティブのものは次の2つ。

- `valueOf(char[] data)`
- `valueOf(Object obj)`

Java 7と8でこれら2つのうちどちらを選択するかが異なっている。

Java 8からジェネリックな戻り値を持つメソッド呼び出しにおける型推論に変更があったのかもしれない（推測。未調査）。
