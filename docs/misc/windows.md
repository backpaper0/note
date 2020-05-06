# Windows

## Macのtimeコマンドみたいなやつ

次のコードを `timeit.bat` という名前でパスの通った場所へ保存する。

```bat
@PowerShell -Command Measure-Command { %* } 
```

次のように時間を計測したいコマンドを引数にして使う。

```bat
timeit java -version
```

## Caps LockをCtrlにする

[Ctrl2Cap](http://technet.microsoft.com/ja-jp/sysinternals/bb897578.aspx) を使う。

## 「無変換」と「変換」をMacの「英数」と「かな」っぽくする

タスクバーの「ツール」をクリックして「プロパティ」を開く。

「全般」タブの編集操作にあるキー設定の「変更」をクリックする。

キー「無変換」の入力/変換済〜の欄を「IME-オフ」に、
キー「変換」の入力/変換済〜の欄を「IME-オン」にする。
