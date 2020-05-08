# WIP: React

- Functional ComponentとHookを使う
- React外のAPIもなるべくHook化するのが良いと思う
    - HTTPリクエスト、WebSocketなど

## renderとDOM更新

- `props`または`state`、Contextが変更されると`render`
- 親コンポーネントが`render`されるとデフォルトでは必ず`render`される
    - [React.memo](https://ja.reactjs.org/docs/react-api.html#reactmemo)を使うと`props`または`state`、Contextが変更したときのみ`render`されるようになる

