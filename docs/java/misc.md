# Javaの雑多なメモ

## JVMのオプションの状態を確認する

- `-XX:+PrintFlagsFinal`

このオプションをコマンドラインに足す。
例えば、

```sh
java -XX:+PrintFlagsFinal -Xmx512m -cp foobar.jar foo.bar.Hoge
```

みたいな感じ。
