_ = require('lodash-core')
bizday = require('../')
moment = require '../lib/moment-with-locales.min.js'
{test} = require 'ava'

test.skip 'constructor date 01', (t) ->
  bd = new bizday()
  bd.val() # '現在の日付'
  bd.add() # '翌営業日の日付'
  return
test 'constructor date 02', (t) ->
  bd = new bizday('2018-01-01')
  t.is bd.val(), '2018-01-01'
  t.is bd.add(), '2018-01-02'
  return
test 'constructor date 03', (t) ->
  bd = new bizday('20180101')
  t.is bd.val(), '2018-01-01'
  t.is bd.add(), '2018-01-02'
  return
test 'constructor format 01', (t) ->
  bd = new bizday('2018-01-01',{format: ''})
  t.true bd.val().includes('2018-01-01T00:00:00')
  t.true bd.add().includes('2018-01-02T00:00:00')
  return
test 'constructor format 02', (t) ->
  bd = new bizday('2018-01-01',{format: 'YYYYMMDD'})
  t.is bd.val(), '20180101'
  t.is bd.add(), '20180102'
  return
test 'constructor type', (t) ->
  bd = new bizday('2017-12-31',{type: 'jp'})
  t.is bd.val(), '2017-12-31'
  t.is bd.add(), '2018-01-02'
  return
test 'constructor reject 01', (t) ->
  bd = new bizday('2018-01-01',{reject: '-01-02'})
  t.is bd.val(), '2018-01-01'
  t.is bd.add(), '2018-01-03'
  return
test 'constructor reject 02', (t) ->
  bd = new bizday('2018-01-01',{reject: /\d{4}-01-\d{2}/})
  t.is bd.val(), '2018-01-01'
  t.is bd.add(), '2018-02-01'
  return
test 'constructor reject 03', (t) ->
  bd = new bizday('2018-01-01',{reject: [
    /\d{4}-01-\d{2}/
    '-02-01'
  ]})
  t.is bd.val(), '2018-01-01'
  t.is bd.add(), '2018-02-02'
  return

test 'add(count)', (t) ->
  bd = new bizday('2018-07-02',{type: 'jp'})
  t.is bd.add(15), '2018-07-24'
  return
test 'sub(count)', (t) ->
  bd = new bizday('2018-07-24',{type: 'jp'})
  t.is bd.sub(15), '2018-07-02'
  return
