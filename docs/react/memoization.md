# 親子関係を持つコンポーネントにおけるrender関数の呼び出しについて

## デフォルトの動作

2つのコンポーネントがあり、それらは親子関係を持つとする。
このとき親コンポーネントの`render`関数が呼ばれると子コンポーネントの`render`関数も呼ばれる。

次の例では`Foo`はstateを2つ持ち、それぞれ1秒毎・5秒毎にインクリメントされる。
また、2つのstateはそれぞれコンポーネント`Bar`のpropsに渡されている。

どちらのstateがインクリメントされても、2つの`Bar`は両方とも`render`関数が呼ばれている。
そのことはコンソールログで確認できる。

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
  return (
    <>
      <Bar name="Bar1" value={value1}/>
      <Bar name="Bar2" value={value2}/>
    </>
  );
};

type BarProps = {
  name: string;
  value: number;
}

const Bar: React.FC<BarProps> = ({ name, value }) => {
  console.log('render', name, ':', value);
  return (
    <></>
  );
};

export { Foo };
```

コンソールログは次のようになる。

```
render Bar1 : 0
render Bar2 : 0
render Bar1 : 1
render Bar2 : 0
render Bar1 : 2
render Bar2 : 0
render Bar1 : 3
render Bar2 : 0
render Bar1 : 4
render Bar2 : 0
render Bar1 : 4
render Bar2 : 1
render Bar1 : 5
render Bar2 : 1
render Bar1 : 6
render Bar2 : 1
render Bar1 : 7
render Bar2 : 1
render Bar1 : 8
render Bar2 : 1
render Bar1 : 9
render Bar2 : 1
render Bar1 : 9
render Bar2 : 2
render Bar1 : 10
render Bar2 : 2
```

## propsの変更がなければ子コンポーネントのrenderが呼ばれないようにする

親コンポーネントの`render`が呼ばれたとき、子コンポーネントへ渡す`props`に変更が無ければ子コンポーネントの`render`は呼ばれないようにするためには`React.memo`を使用する。

単に子コンポーネントへ`React.memo`を適用すれば良い。

次に示す例は、前セクションで示した例から`Bar`へ`React.memo`を適用したもの。

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
  return (
    <>
      <BarMemoized name="Bar1" value={value1}/>
      <BarMemoized name="Bar2" value={value2}/>
    </>
  );
};

type BarProps = {
  name: string;
  value: number;
}

const Bar: React.FC<BarProps> = ({ name, value }) => {
  console.log('render', name, ':', value);
  return (
    <></>
  );
};

const BarMemoized = React.memo(Bar);

export { Foo };
```

コンソールログを見ると`value1`が変更されたときは`Bar1`の`render`のみが呼ばれ、`value2`が変更されたときは`Bar2`の`render`のみが呼ばれていることがわかる。

```
render Bar1 : 0
render Bar2 : 0
render Bar1 : 1
render Bar1 : 2
render Bar1 : 3
render Bar1 : 4
render Bar2 : 1
render Bar1 : 5
render Bar1 : 6
render Bar1 : 7
render Bar1 : 8
render Bar1 : 9
render Bar2 : 2
render Bar1 : 10
```

`React.memo`について詳しくは公式ドキュメントを参照のこと。

- [React.memo](https://ja.reactjs.org/docs/react-api.html#reactmemo)

## パフォーマンスチューニング

`render`が高コストな場合、`React.memo`を利用することで`render`の回数を減らしてパフォーマンスを向上させることができるかもしれない。

そういったパフォーマンスチューニングをする余地を残すためにコンポーネントはある程度小さく(曖昧な表現)分割するのが良いと思われる。

