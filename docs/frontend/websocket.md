# WIP: WebSocket

## 考慮すべき点

- バックエンドからのタイムアウト
    - フロントエンドから数秒間隔でのPING
- URLは`ws:`または`wss:`から始まる絶対URL
    - URLを返すREST APIエンドポイントを用意する
