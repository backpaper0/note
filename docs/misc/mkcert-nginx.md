# mkcertとNginxを使ってローカルでHTTPSする

## 概要

- `mkcert`で証明書を発行する
- Nginxへ証明書を組み込みHTTPSのサーバーを立てる
- `hosts`ファイルを編集してホスト名を`127.0.0.1`へマッピングする

## 準備

`mkcert`をインストールする。

- https://github.com/FiloSottile/mkcert

NginxはDockerを使う。

## mkcertで証明書を発行する

```
mkcert -key-file key.pem -cert-file cert.pem "*.example.com"
```

## Nginxへ証明書を組み込みHTTPSのサーバーを立てる

`https.conf`という名前のファイルを作成して次の内容を書く。

```
server {
    listen       443 ssl;
    server_name  localhost.example.com;
    ssl_certificate     cert.pem;
    ssl_certificate_key key.pem;
    ssl_protocols       TLSv1 TLSv1.1 TLSv1.2;
    ssl_ciphers         HIGH:!aNULL:!MD5;

    location / {
        root   /usr/share/nginx/html;
        index  index.html index.htm;
    }

    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
}
```

次のコマンドでNginxを起動する。

```
docker run -it --rm -p 8443:443 -p 8080:80 \
    -v $(pwd)/https.conf:/etc/nginx/conf.d/https.conf \
    -v $(pwd)/cert.pem:/etc/nginx/cert.pem \
    -v $(pwd)/key.pem:/etc/nginx/key.pem nginx
```

## hostsファイルを編集してホスト名を127.0.0.1へマッピングする

```
sudo vim /etc/hosts
```

```
127.0.0.1       localhost.example.com
```

## 動作確認

ブラウザで https://localhost.example.com:8443 へアクセスする。
