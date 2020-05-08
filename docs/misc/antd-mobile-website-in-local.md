# Ant-Design-Mobileのウェブサイトをローカルで見る

たまに重過ぎてやってられないときがあるのでローカルで見る方法を書いておきます。

```
git clone git@github.com:ant-design/ant-design-mobile.git
cd ant-design-mobile
npm install
npm run site
cd _site
npm install -g serve
serve
```

これで http://localhost:5000 を開くとAnt Design Mobileのウェブサイトが見られます。

なお、このままではコンポーネントのページにある例が見られませんので、別途 `npm start` でコード例を起動してください。
