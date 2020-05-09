# renderが呼び出される条件

次のいずれかの値が変更されたときコンポーネントの`render`関数は呼び出される。

- コンポーネントに渡されたprops
- コンポーネントが持つstate
- コンポーネントが参照しているcontext

## コンポーネントに渡されたprops

2つのコンポーネント`Foo`と`Bar`がある。
`Foo`が親で`Bar`が子の関係になっている。
`Foo`は`value`という数値のstateを持っており、1秒毎にインクリメントしている。
`Bar`のpropsには`value`が渡されている。

コンポーネントに渡されたpropsの値が変更されたときコンポーネントの`render`関数は呼び出されるため、`Bar`の`render`は1秒毎に呼び出される。
そのことはコンソールログで確認できる。

```
import React, { useState } from 'react';

const Foo: React.FC = () => {
  const [value, setValue] = useState(0);
  window.setTimeout(() => {
    setValue(value + 1);
  }, 1000);
  return (
    <>
      <Bar value={value}/>
    </>
  );
};

const Bar: React.FC<BarProps> = ({ value }) => {
  console.log('render Bar ', value);
  return (
    <></>
  );
};

type BarProps = { value: number; }

export { Foo };
```

## コンポーネントが持つstate

コンポーネント`Foo`がある。
`Foo`は`value`という数値のstateを持っており、1秒毎にインクリメントしている。

コンポーネントが持つstateの値が変更されたときコンポーネントの`render`関数は呼び出されるため、`Foo`の`render`は1秒毎に呼び出される。
そのことはコンソールログで確認できる。

```
import React, { useState } from 'react';

const Foo: React.FC = () => {
  const [value, setValue] = useState(0);
  console.log('render Foo ', value);
  window.setTimeout(() => {
    setValue(value + 1);
  }, 1000);
  return (
    <></>
  );
};

export { Foo };
```

## コンポーネントが参照しているcontext

3つのコンポーネント`Foo`と`Bar`と`Baz`がある。
`Foo`と`Bar`が親子、さらに`Bar`と`Baz`が親子の関係になっている。
`Foo`は`value`という数値のstateを持っており、1秒毎にインクリメントしている。
`Baz`はcontextを経由して`value`を参照している。

コンポーネントが参照しているcontextの値が変更されたときコンポーネントの`render`関数は呼び出されるため、`Baz`の`render`は1秒毎に呼び出される。
そのことはコンソールログで確認できる。

```
import React, { useState, useContext } from 'react';

const ValueContxt = React.createContext(0);

const Foo: React.FC = () => {
  const [value, setValue] = useState(0);
  window.setTimeout(() => {
    setValue(value + 1);
  }, 1000);
  return (
    <ValueContxt.Provider value={value}>
      <Bar/>
    </ValueContxt.Provider>
  );
};

const Bar: React.FC = () => {
  return (
    <Baz/>
  );
};

const Baz: React.FC = () => {
  const value = useContext(ValueContxt);
  console.log('render Baz ', value);
  return (
    <></>
  );
};

export { Foo };
```

