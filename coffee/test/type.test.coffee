_ = require('lodash')
bizday = require('../')
moment = require 'moment'
{test} = require 'ava'

test 'type is default', (t) ->
  bd = new bizday('20161229')
  t.is bd.val(), '20161229'
  t.is bd.add(), '20161230'
  t.is bd.add(), '20170102'
  t.is bd.add(), '20170103'
test 'type is tse', (t) ->
  bd = new bizday('20151229', {type: 'tse'})
  t.is bd.val(), '20151229'
  t.is bd.add(), '20151230'
  t.is bd.add(), '20160104'
  t.is bd.add(), '20160105'
test 'type is TSE', (t) ->
  bd = new bizday('20151229', {type: 'TSE'})
  t.is bd.val(), '20151229'
  t.is bd.add(), '20151230'
  t.is bd.add(), '20160104'
  t.is bd.add(), '20160105'
test 'type is Government', (t) ->
  bd = new bizday('20161227', {type: 'Government'})
  t.is bd.val(), '20161227'
  t.is bd.add(), '20161228'
  t.is bd.add(), '20170104'
  t.is bd.add(), '20170105'
test 'type is government', (t) ->
  bd = new bizday('20161227', {type: 'government'})
  t.is bd.val(), '20161227'
  t.is bd.add(), '20161228'
  t.is bd.add(), '20170104'
  t.is bd.add(), '20170105'
test 'type is go', (t) ->
  bd = new bizday('20161227', {type: 'go'})
  t.is bd.val(), '20161227'
  t.is bd.add(), '20161228'
  t.is bd.add(), '20170104'
  t.is bd.add(), '20170105'
test 'type is gov', (t) ->
  bd = new bizday('20161227', {type: 'gov'})
  t.is bd.val(), '20161227'
  t.is bd.add(), '20161228'
  t.is bd.add(), '20170104'
  t.is bd.add(), '20170105'
test 'type is unknown is default calendar', (t) ->
  bd = new bizday('20161227', {type: 'unknown'})
  t.is bd.val(), '20161227'
  t.is bd.add(), '20161228'
  t.is bd.add(), '20161229'
  t.is bd.add(), '20161230'
  t.is bd.add(), '20170102'
  t.is bd.add(), '20170103'