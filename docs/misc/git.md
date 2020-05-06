# Git

## git add -p で hunk をもっと細かく分割する

`git add -p` すると

 Stage this hunk [y,n,q,a,d,/,e,?]?

と聞かれるけど、ここで s を入力する。

addのヘルプによると s は

 split the current hunk into smaller hunks

らしい。

## リモートのブランチを消す

例えばリモートのhogeブランチを消したい場合。

```sh
git push origin :hoge
```

## リモートで消されたブランチのローカルの参照も消す

リモートブランチを消すのと同じかな？と思って `git push origin :hoge` とかやると
`error: unable to delete 'hoge': remote ref does not exist` みたいに言われてしまう。

リモートからは既に削除されているので、そりゃそうか、と。

次のコマンドでリモートブランチの状態をローカルに反映する。

```sh
git remote prune origin
```

## コミット毎のパッチを作る・パッチを適用する

`format-patch` コマンドでパッチを作る。
`-o` で出力先ディレクトリを指定する。
オペランドでコミットを指定する。
次のコマンドだと `~/src/temp/` ディレクトリに
`HEAD` から10コミット分のパッチを作る。

```sh
git format-patch -o ~/src/temp/ @~10
```

作ったパッチを適用するには `am` コマンドを使う。
オペランドでパッチファイルのパスを指定する。
ワイルドカードで複数ファイルを指定できる。

```sh
git am ~/src/temp/*.patch
```

## git filter-branch

バックアップは `.git/refs/original` にあるっぽい。

### authorとcommitterを一括で書き換える

```sh
git filter-branch --commit-filter '
GIT_AUTHOR_EMAIL="foo@hoge.com"
GIT_COMMITTER_EMAIL="foo@hoge.com"
git commit-tree "$@"
' @
```

## zipファイルでエクスポートする

```sh
git archive --format=zip @ > ../hoge.zip
```

## ふたつのタグ間のコミットログを見る

`git log` のオペランドにタグ名を `..` で区切って指定する。

例えばDomaの `2.5.1` から `2.6.0` の間のコミットログを見る場合は次のようにする。

```sh
git log 2.5.1..2.6.0
```

## git grepとsedで置換する

```sh
git grep -l hoge|xargs sed -i '' -e 's/hoge/fuga/g'
```

## すべてのブランチでgit grepする

```sh
git grep "検索ワード" $(git branch|cut -c 3-)
```

## worktreeを作り直す

`worktree` のディレクトリを削除したらなんか変になったけど `.git/worktree` を削除したら直った。

`rm -fr .git/worktree` してから、また `git worktree add path/to/worktree some-branch` をすればOK。
たぶん。

## ファイル一覧系

まとめてvimで開いたり `sed` で処理したりするためにファイルを一覧するコマンドを知っておきたい。

### git grep -l

`git grep` は `-l` オプションを付けるとでヒットしたファイルを一覧できる。

```
git grep -l foobar
```

### git ls-files

Gitで管理しているファイルの一覧は `git ls-files` で取得できる。

```
git ls-files **/*.java
```

## GitHub

[GitHub](https://github.com/) に関する事はここに書く。

### プルリクエストのコミットをローカルに持ってくる

例えば次のプルリクエストをフェッチする場合、

- https://github.com/backpaper0/memo/pull/1

プルリクエストのIDが `1` なので次のコマンドでフェッチして `hoge` ブランチが作られる。

```sh
git fetch origin pull/1/head:hoge
```

参考 https://help.github.com/articles/checking-out-pull-requests-locally/
