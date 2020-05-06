# readline7系を失う問題

## 問題

```
Library not loaded: /usr/local/opt/readline/lib/libreadline.7.dylib
```

## 解決方法

```
git clone git@github.com:Homebrew/homebrew-core.git
cd homebrew-core
git log -10 Formula/readline.rb
```

7系のコミットを探して`git checkout -b`する。

新たにGitリポジトリを作って7系の`readline.rb`をコピーする。

```
git tap uragami/brew /path/to/repository
brew reinstall uragami/brew/readline
brew switch readline 7.0.5
```
