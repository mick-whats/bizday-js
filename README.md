# bizday

これはbizday(=営業日)を操作するライブラリです。

```
bd = new bizday('2018-05-01')
bd.val() // '2018-05-01'
bd.add() // '2018-05-02'
bd.sub() // '2018-05-01'
bd.val() // '2018-05-01'
```

## constructor

```js
new bizday(date, opts)
```

### date (string)
日付の初期値を設定します。'2018-01-01','20180101'といった形式が使用できます。省略すると現在の日付になります。

```js
var bd;
bd = new bizday();
bd.val(); // '現在の日付'
bd.add(); // '翌営業日の日付;
```

```js
var bd;
bd = new bizday('20180101');
bd.val() // '2018-01-01'
bd.add() // '2018-01-02'
```

```js
var bd;
bd = new bizday('2018-01-01');
bd.val()// '2018-01-01'
bd.add()// '2018-01-02'
```

### [opts.format] (string)
出力するformatを指定します。formatはMoment.jsに準拠します。  
[Moment\.js \| Docs](http://momentjs.com/docs/#/displaying/format/)


```js
var bd;
bd = new bizday('2018-01-01', {format: ''});
bd.val() // '2018-01-01T00:00:00+09:00'
bd.add() // '2018-01-02T00:00:00+09:00'
```

```js
var bd;
bd = new bizday('2018-01-01', {format: 'YYYYMMDD'});
bd.val() // '20180101'
bd.add() // '20180102'
```


### [opts.type] (string)
このオプションをつけない場合、営業日は土日以外となります。しかし実際には祝日も営業していない事が多いので、`type`オプションを設定する事で祝日を考慮した営業日を使用できます。

#### type: 'jp'
日本の祝日を考慮します。元旦は祝日ですが1月2日は平日の場合営業日になります。

#### type: 'go'
日本の官公庁の営業日です。土日と祝日、12月29日から１月３日までを除いた日になります。

参考: [行政機関の休日に関する法律](http://www.houko.com/00/01/S63/091.HTM)

#### type: 'tse'
東京証券取引所の営業日です。土日と祝日、12月31日から１月３日までを除いた日になります。

```js
var bd;
bd = new bizday('2017-12-31', {type: 'jp'});
bd.val() // '2017-12-31'
bd.add() // '2018-01-02'
```
### [opts.reject] (string | RegExp)
営業日から除外する日付を指定します。文字列または正規表現が使用できます。  
文字列の場合、内部では`String.prototype.includes()`で判定しています。

```js
var bd;
bd = new bizday('2018-01-01', {reject: '-01-02'});
bd.val() // '2018-01-01'
bd.add() // '2018-01-03'
```
例えば１月２日を除外したい場合に`'01-02'`とすると、`〇〇01年02月`も全て除外されるので注意が必要です。

```js
var bd;
bd = new bizday('2018-01-01', {reject: /\d{4}-01-\d{2}/});
bd.val() // '2018-01-01'
bd.add() // '2018-02-01'
```

複数指定する場合は配列に格納します。
```js
var bd;
bd = new bizday('2018-01-01', {
  reject: [
    /\d{4}-01-\d{2}/,
    '-02-01'
    ]
});
bd.val() // '2018-01-01'
bd.add() // '2018-02-02'
```
---
## method
### val()

インスタンスが保持している日付を返します。
```js
var bd;
bd = new bizday('2018-01-01');
bd.val()// '2018-01-01'
```

### add(count)
日付を進めて更新し、その日付を返します。
引数を省略した場合、翌営業日に更新します。
```js
var bd;
bd = new bizday('2018-07-02');
bd.val()// '2018-07-02'
bd.add()// '2018-07-03'
```

引数として日数xを指定するとx営業日後の日付に更新します。

```js
var bd;
bd = new bizday('2018-07-02', {type: 'jp'});
bd.add(15) // '2018-07-24'
```


### sub(count)
日付を戻して更新し、その日付を返します。
引数を省略した場合、前営業日に更新します。

```js
var bd;
bd = new bizday('2018-07-02');
bd.val()// '2018-07-02'
bd.sub()// '2018-06-29'
```

引数として日数xを指定するとx営業日前の日付に更新します。

```js
var bd;
bd = new bizday('2018-07-24', {type: 'jp'});
bd.sub(15) // '2018-07-02'
```

## warning

- 対応しているのは2000-01-01から2030-12-31の間だけです。範囲を超えると例外をthrowします。
- 未来の祝日に関しては変わる可能性があります。

## thanks

祝日のデータに関してはこちらからお借りしています。  
[holiday\-jp/holiday\_jp\-ruby: Japanese holiday\.](https://github.com/holiday-jp/holiday_jp-ruby)