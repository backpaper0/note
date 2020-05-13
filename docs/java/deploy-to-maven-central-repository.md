# Maven Central Repositoryへデプロイする

## OSSRHへissueを登録する

- [Open Source Software Repository Hosting](https://issues.sonatype.org/)

アカウントがなければ作る。

アカウントができたらissueを登録する。

参考

- https://issues.sonatype.org/browse/OSSRH-38897

このときissueへ記載するGroup Idは自分が所有しているドメインをもとに組み立てたものにする。
あるいは`com.github.<username>`でも良いらしい。

ここで登録されたGroup Id配下であれば今後はissue登録しなくても自由にデプロイできる。

## 鍵の準備をする

- GPG鍵
- Mavenのマスターパスワード

GPG鍵はアーティファクトへ署名するために必要。

Mavenのマスターパスワードは`settings.xml`で設定するサーバーのパスワードを暗号化して記載するために必要。

### GPG鍵を生成する

GPGをインストールしていなかったらする。
MacならHomebrewでインストールできる。

```
brew install gnupg
```

環境変数`GPG_TTY`の設定が必要。

```
export GPG_TTY=$(tty)
```

鍵を生成する。
RSA 4096ビットを選択するために`--gen-key`ではなく`--full-gen-key`を実行する。

```
gpg --full-gen-key
```

生成された鍵には`F572D396FAE9206628714FB2CE00F72E94F2258F`というような名前が付けられる。
この名前を指定して鍵(公開鍵)を鍵サーバーへ登録する。

```
gpg --keyserver hkp://pool.sks-keyservers.net --send-keys F572D396FAE9206628714FB2CE00F72E94F2258F
```

### WIP: 秘密情報を暗号化してsettings.xmlへ書く

参考

- https://maven.apache.org/guides/mini/guide-encryption.html

