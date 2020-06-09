# WIP: トークンのブラウザでの持ち方について

- Cookie
    - クロスドメインで送信される(CSRFの隙)
        - SameSite
    - Domainディレクティブを設定するとサブドメインでも使えるようになる
        - Domainディレクティブを設定しないとCookieを発行したホストのみ
        - Domainディレクティブは設定しない方が安全
    - Secureディレクティブ
    - HttpOnlyディレクティブ
        - JavaScriptからアクセスできなくなる(XSS対策)
- LocalStorage(SessionStorage) + リクエストヘッダ
    - JavaScriptで明示的にトークンを取り出してリクエストヘッダに付与しないといけない(CSRFは起こらない)
    - オリジン毎に区切られた保存領域
    - SessionStorageはタブ間で共有されない、LocalStorageはブラウザが終了しても残る、つまりセッションCookieと同等のスコープは実現できない
- インメモリ + リクエストヘッダ
    - CSRFは起こらない
    - タブの終了、リロードで消える

Secure、HttpOnly、SameSiteを付けたCookieがベストでは？

