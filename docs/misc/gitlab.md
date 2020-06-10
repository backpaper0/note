# GitLab

APIを使うための準備。
このメモ内では次の環境変数を使っている。

```
export GITLAB_PERSONAL_ACCESS_TOKEN=
export PROJECT_ID=
```

## Time Trackingを行う

- [Time Tracking | GitLab](- https://docs.gitlab.com/ce/user/project/time_tracking.html)

IssueやMRのコメント欄で`/estimate 1h`などと入力して送信すれば、そのIssue(またはMR)に対して見積もり工数を設定できる。

`/spend`で実績の入力もできる。

`/estimate`は既に値が設定されている場合は新しい値で上書きされる。
`/spend`は既に値が設定されている場合は、その値と新しい値の合計値が設定される。

見積もり工数の合計値を取得するには次のようにAPIを使用すれば良い。

```
curl -s -H "Authorization: Bearer $GITLAB_PERSONAL_ACCESS_TOKEN" \
  "https://gitlab.com/api/v4/projects/$PROJECT_ID/issues?per_page=1000" | \
  jq '[.[] | select(.state == "opened") | .time_stats.time_estimate] | add / 60 / 60'
```

- デフォルトだと1度に返すIssueの数が少ないのでクエリパラメーター`per_page`を大きめの値にしている
- `time_estimate`の値は単位が秒なので最後に除算をして単位を時間に変換している

## ショートカット

全てのショートカットは`?`を押せば見られる。
ここでは自分がよく使うものを記載しておく。

|操作|ショートカット|
|---|---|
|Issueの本文を編集する|`e`|
|Issueのコメント入力欄にフォーカスする|`r`|
|入力中のIssueの本文やコメントを確定する|`Ctrl + Enter`|
|リポジトリ内のファイルを検索する|`t`|
|プロジェクトのトップへ移動する|`g p`|
|プロジェクトのIssue一覧へ移動する|`g i`|
|プロジェクトのIssueボードへ移動する|`g b`|
|プロジェクトのMR一覧へ移動する|`g m`|
|プロジェクトのジョブ一覧へ移動する|`g j`|
