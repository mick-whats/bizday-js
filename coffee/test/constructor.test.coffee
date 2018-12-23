_ = require('lodash-core')
bizday = require('../')
moment = require 'moment'
{test} = require 'ava'

test 'bizday', (t) ->
  bd = new bizday()
  t.is bd.val(), moment().format('YYYY-MM-DD')
test 'bizday with format', (t) ->
  bd = new bizday(null, {format: 'YYYYMMDD'})
  t.is bd.val(), moment().format('YYYYMMDD')
test 'bizday with type is jp', (t) ->
  bd = new bizday(null, {type: 'jp'})
  t.false _.includes bd.list, '2018-05-03'
