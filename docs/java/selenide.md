# Selenide

IEでテスト失敗するとIEDriverServer.exeが生き残ってる場合があるのでそれを消す作業について書いておく。

次のコマンドでプロセスが残っているか確認する。

```none
tasklist|findstr IEDriverServer.exe
```

次のコマンドでプロセスを強制終了させる。

```none
taskkill /f /im IEDriverServer.exe
```
