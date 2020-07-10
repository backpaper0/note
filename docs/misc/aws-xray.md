# AWS X-Rayをローカルで試す

トレースログの確認はマネジメントコンソールで見るしかないけれど、トレースログの送信まではローカルでも行える。

## IAMユーザーを準備する

あらかじめ`AWSXrayFullAccess`を持つIAMユーザーを作成してアクセスキーを生成しておく。

## 設定を行う

ローカルに直接`aws-cli`を入れたくないのでコンテナイメージを使う。

```
docker run --rm -it -v ~/.aws:/root/.aws --entrypoint bash amazon/aws-cli
```

コンテナ内で設定をする。

```
aws configure --profile xray
```

## デーモンを立ち上げる

インストール方法は次のウェブページを参照すること。

- [https://docs.aws.amazon.com/ja_jp/xray/latest/devguide/xray-daemon-local.html](https://docs.aws.amazon.com/ja_jp/xray/latest/devguide/xray-daemon-local.html)

次のコマンドで起動する(Macの場合)。

```
AWS_PROFILE=xray ./xray_mac -o -n ap-northeast-1
```

## トレースログを記録する

WIP

