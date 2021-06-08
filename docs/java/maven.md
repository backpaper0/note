# Maven

## システムプロパティ

実行時にシステムプロパティで設定を上書きできます。

|プロパティ|説明|
|---|---|
|`maven.repo.local`|ローカルリポジトリのパス|

## 処理をスキップする

|スキップする処理|ユーザープロパティ|
|---|---|
|`compiler:compile`|`-Dmaven.main.skip`|
|`compiler:testCompile`<br>`resources:testResources`<br>surefire:test|`-Dmaven.test.skip`|
|`resources:resources`|`-Dmaven.resources.skip`|
|`surefire:test`|`-DskipTests`|
|`javadoc:javadoc`<br>`javadoc:test-javadoc`<br>`javadoc:jar`<br>`javadoc:test-jar`|`-Dmaven.javadoc.skip=true`|
|`source:jar`<br>`source:test-jar`|`-Dmaven.source.skip=true`|
|`spotbugs:check`<br>`spotbugs:spotbugs`|`-Dspotbugs.skip=true`|
|`checkstyle:check`<br>`checkstyle:checkstyle`|`-Dcheckstyle.skip=true`|
|`gpg:sign`|`-Dgpg.skip=true`|

## Gitリポジトリ内にあるすべてのMavenプロジェクトをビルドする

```sh
git ls-files -- '**/pom.xml' | xargs -t -I {} mvn -f {} clean
```

`for`でもできる。

```sh
for i in `git ls-files -- **/pom.xml`; do mvn -f $i clean package; done
```

## Java 8で動かしながらコンパイルはJava 7、テストはJava 11で行う

`maven.compiler.executable`には`javac`を指定します。
また、`maven.compiler.executable`を設定する場合は`maven.compiler.fork`を`true`にする必要があります。

```
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
mvn test \
  -Dmaven.compiler.executable=$(/usr/libexec/java_home -v 1.7)/bin/javac \
  -Dmaven.compiler.fork=true \
  -Djvm=$(/usr/libexec/java_home -v 11)/bin/java
```

## Maven Wrapper

- https://github.com/takari/maven-wrapper

`java`コマンドに渡すオプションを`.mvn/jvm.config`で設定できる。

たとえばプロキシの設定をしたい場合は次のように書くと良い。

```
-Dhttp.proxyHost=proxy.example.com
-Dhttp.proxyPort=3128
-Dhttps.proxyHost=proxy.example.com
-Dhttps.proxyPort=3128
-Dhttp.nonProxyHosts=localhost
```
