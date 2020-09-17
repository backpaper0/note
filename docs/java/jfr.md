# Java Flight Recorder

`java`コマンドに`-XX:StartFlightRecording`オプションを付ける。

```
java -XX:StartFlightRecording="filename=target/record.jfr" -cp "target/classes:target/dependency/*" com.example.App
```

ちなみに`jcmd`でもフライトレコーダーの開始・終了などができるっぽい。

フライトレコードのファイル(なんて呼称するんだろう？)は[VisualVM](https://visualvm.github.io/)やJDK Mission Controlで見られる。

