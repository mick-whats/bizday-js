_ = require('lodash-core')
bizday = require('../')
moment = require 'moment'
{test} = require 'ava'

test 'reject with string', (t) ->
  bd = new bizday('2015-12-31', {reject: ['2016']})
  t.is bd.val(), '2015-12-31'
  t.is bd.add(), '2017-01-02'

test 'reject with string (not array)', (t) ->
  bd = new bizday('2015-12-31', {reject: '2016'})
  t.is bd.val(), '2015-12-31'
  t.is bd.add(), '2017-01-02'

test 'reject with string 2', (t) ->
  bd = new bizday('2015-12-31', {reject: ['2016', '01-02']})
  t.is bd.val(), '2015-12-31'
  t.is bd.add(), '2017-01-03'

test 'reject with regex', (t) ->
  bd = new bizday('2015-12-31', {reject: [/2016/]})
  t.is bd.val(), '2015-12-31'
  t.is bd.add(), '2017-01-02'

test 'reject with regex (not array)', (t) ->
  bd = new bizday('2015-12-31', {reject: /2016/})
  t.is bd.val(), '2015-12-31'
  t.is bd.add(), '2017-01-02'

test 'reject with regex 2', (t) ->
  bd = new bizday('2015-12-31', {reject: [/01-01/, /01-02/]})
  t.is bd.val(), '2015-12-31'
  t.is bd.add(), '2016-01-04'

test 'reject with regex and string', (t) ->
  bd = new bizday('2015-12-31', {reject: [/2016/, '01-02', /01-03/]})
  t.is bd.val(), '2015-12-31'
  t.is bd.add(), '2017-01-04'
