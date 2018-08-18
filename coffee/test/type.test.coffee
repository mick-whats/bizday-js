_ = require('lodash')
bizday = require('../')
moment = require 'moment'
{test} = require 'ava'

test 'type is default', (t) ->
  bd = new bizday('2016-12-29')
  t.is bd.val(), '2016-12-29'
  t.is bd.add(), '2016-12-30'
  t.is bd.add(), '2017-01-02'
  t.is bd.add(), '2017-01-03'
test 'type is tse', (t) ->
  bd = new bizday('2000-12-29', {type: 'tse'})
  t.is bd.val(), '2000-12-29'
  t.is bd.add(), '2001-01-04'
  t.is bd.add(24), '2001-02-08'
  t.is bd.add(24), '2001-03-15'
  t.is bd.add(24), '2001-04-19'
test 'type is TSE', (t) ->
  bd = new bizday('2015-12-29', {type: 'TSE'})
  t.is bd.val(), '2015-12-29'
  t.is bd.add(), '2015-12-30'
  t.is bd.add(), '2016-01-04'
  t.is bd.add(), '2016-01-05'
test 'type is Government', (t) ->
  bd = new bizday('2016-12-27', {type: 'Government'})
  t.is bd.val(), '2016-12-27'
  t.is bd.add(), '2016-12-28'
  t.is bd.add(), '2017-01-04'
  t.is bd.add(), '2017-01-05'
test 'type is government', (t) ->
  bd = new bizday('2016-12-27', {type: 'government'})
  t.is bd.val(), '2016-12-27'
  t.is bd.add(), '2016-12-28'
  t.is bd.add(), '2017-01-04'
  t.is bd.add(), '2017-01-05'
test 'type is go', (t) ->
  bd = new bizday('2016-12-27', {type: 'go'})
  t.is bd.val(), '2016-12-27'
  t.is bd.add(), '2016-12-28'
  t.is bd.add(), '2017-01-04'
  t.is bd.add(), '2017-01-05'
test 'type is gov', (t) ->
  bd = new bizday('2016-12-27', {type: 'gov'})
  t.is bd.val(), '2016-12-27'
  t.is bd.add(), '2016-12-28'
  t.is bd.add(), '2017-01-04'
  t.is bd.add(), '2017-01-05'
test 'type is unknown is default calendar', (t) ->
  bd = new bizday('2016-12-27', {type: 'unknown'})
  t.is bd.val(), '2016-12-27'
  t.is bd.add(), '2016-12-28'
  t.is bd.add(), '2016-12-29'
  t.is bd.add(), '2016-12-30'
  t.is bd.add(), '2017-01-02'
  t.is bd.add(), '2017-01-03'