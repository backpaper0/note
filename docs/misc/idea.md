# IntelliJ IDEA

## ショートカット

|コマンド|説明|
|---|---|
|`command + shift + A`|設定とかツールとか色々開く事が出来る便利なやつ。便利。|
|`shift shift`|型とか他のファイルとか色々開く事が出来る便利なやつ。便利すぎて鼻血出る。|

## Java 6ランタイムが必要と言われる件

`/Applications/IntelliJ IDEA 13 CE.app/Contents/Info.plist` をエディタで開く。

```xml
<key>JVMVersion</key>
<string>1.6*</string>
```

を

```xml
<key>JVMVersion</key>
<string>1.8*</string>
```

にする。

## Vimキーバインドにする

IdeaVimというプラグインを入れる。

## 匿名クラスをラムダ式っぽく見せる機能をOFFにする

訓練されたJava屋さんなので、特に何もしなくても匿名クラスはラムダ式に見える！！！

設定を`Editor -> General -> Code Folding`と辿って`Closures`のチェックを外せば良さそう。

## メソッド呼び出しの箇所から引数名を消す

訓練されたJava屋さんなので、Javaの文法に無い表示をされると混乱する！！！

設定を`Editor -> General -> Appearance`と辿って`Show parameter name hints`のチェックを外せば良さそう。
