# コンポーネントへ渡す関数について

## コンポーネントへ関数を渡す

コンポーネントには関数を渡せる。

次の例はコンポーネント`Bar`に`fn`という名前で関数を渡している。

```
import React from 'react';

const Foo: React.FC = () => {
  const fn = () => {
    return 'hello';
  };
  return (
    <Bar fn={fn}/>
  );
};

type BarProps = {
  fn: () => string;
}

const Bar: React.FC<BarProps> = ({ fn }) => {
  return (
    <>{fn()}</>
  );
};

export { Foo };
```

## メモ化されたコンポーネントへ関数を渡す

[親子関係を持つコンポーネントにおけるrender関数の呼び出しについて](memoize-component.md)で説明した`React.memo`を適用したコンポーネントを用意する。
そのコンポーネントへ関数を渡すと、`props`が変更されていないのに`render`が呼ばれているように見える。

次の例は[親子関係を持つコンポーネントにおけるrender関数の呼び出しについて](memoize-component.md)で示した例をもとにして`Bar`へ関数を渡すようにしたもの。

```
import React, { useState } from 'react';

function useValue(delay: number): number {
  const [value, setValue] = useState(0);
  window.setTimeout(() => {
    setValue(value + 1);
  }, delay);
  return value;
}

const Foo: React.FC = () => {
  const value1 = useValue(1000);
  const value2 = useValue(5000);
  const fn = (a: number) => a * 2;
  return (
    <>
      <BarMemoized name="Bar1" value={value1} fn={fn}/>
      <BarMemoized name="Bar2" value={value2} fn={fn}/>
    </>
  );
};

type BarProps = {
  name: string;
  value: number;
  fn: (a: number) => number;
}

const Bar: React.FC<BarProps> = ({ name, value, fn }) => {
  console.log('render', name, ':', fn(value));
  return (
    <></>
  );
};

const BarMemoized = React.memo(Bar);

export { Foo };
```

コンソールログを見ると`value2`は変更されていないのに`Bar2`の`render`が呼ばれていることがわかる。

```
render Bar1 : 0
render Bar2 : 0
render Bar1 : 2
render Bar2 : 0
render Bar1 : 4
render Bar2 : 0
render Bar1 : 6
render Bar2 : 0
render Bar1 : 8
render Bar2 : 0
```

これは`Foo`の`render`が呼ばれる毎に関数`fn`のインスタンス(と表現しても良いのかな？ JavaScript的にどう表現するのが正確かは知らない)が生成されることが原因。

## メモ化されたコンポーネントのprops比較処理

`React.memo`でメモ化されたコンポーネントは`shallowEqual`という関数を使って`props`の比較が行われる。

- [propsを比較している箇所](https://github.com/facebook/react/blob/v16.13.1/packages/react-reconciler/src/ReactFiberBeginWork.js#L455-L457)
- [shallowEqual](https://github.com/facebook/react/blob/v16.13.1/packages/shared/shallowEqual.js)
- [objectIs](https://github.com/facebook/react/blob/v16.13.1/packages/shared/objectIs.js) ... `shallowEqual`の内部で使われており、[Object.is](https://developer.mozilla.org/ja/docs/Web/JavaScript/Reference/Global_Objects/Object/is)があればそれを使い、なければポリフィルを使う関数

なお、`shallowEqual`の詳細はここでは説明しない。

`Object.is`はシグネチャが同じ関数であっても異なるインスタンスであれば`false`を返す。

```
const f = a => a;
const g = a => a;

console.log(Object.is(f, g)); // false
console.log(Object.is(f, f)); // true
```

つまり、`React.memo`でメモ化したコンポーネントへ関数を渡す場合、その関数は毎回同じインスタンスを渡さなければメモ化の恩恵を受けられない。

## 関数をメモ化する

[useCallback](https://ja.reactjs.org/docs/hooks-reference.html#usecallback)を使えば関数をメモ化できる。
`useCallback`は依存する値の配列を第2引数へ渡すが、値に変更がなければ同じ関数インスタンスを返す。

次の例はメモ化された`Bar`へ渡す関数を`useCallback`でメモ化している。
なお、この関数は外部のスコープにある変数を参照していないので`useCallback`の第2引数は空の配列を渡している。
つまり、`useCallback`からはずっと同じ関数インスタンスを返される。

```
import React, { useState, useCallback } from 'react';

function useValue(delay: number): number {
  const [value, setValue] = useState(0);
  window.setTimeout(() => {
    setValue(value + 1);
  }, delay);
  return value;
}

const Foo: React.FC = () => {
  const value1 = useValue(1000);
  const value2 = useValue(5000);
  const fn = useCallback((a: number) => a * 2, []);
  return (
    <>
      <BarMemoized name="Bar1" value={value1} fn={fn}/>
      <BarMemoized name="Bar2" value={value2} fn={fn}/>
    </>
  );
};

type BarProps = {
  name: string;
  value: number;
  fn: (a: number) => number;
}

const Bar: React.FC<BarProps> = ({ name, value, fn }) => {
  console.log('render', name, ':', fn(value));
  return (
    <></>
  );
};

const BarMemoized = React.memo(Bar);

export { Foo };
```

コンソールログを見ると`Bar2`の`render`は呼ばれていないことがわかる。

```
render Bar1 : 0
render Bar2 : 0
render Bar1 : 2
render Bar1 : 4
render Bar1 : 6
render Bar1 : 8
```

