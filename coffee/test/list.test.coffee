_ = require('lodash')
bizday = require('../')
moment = require 'moment'
{test} = require 'ava'

test 'reject with string', (t) ->
  bd = new bizday('20151231', {reject: ['2016']})
  t.is bd.val(), '20151231'
  t.is bd.add(), '20170102'

test 'reject with string (not array)', (t) ->
  bd = new bizday('20151231', {reject: '2016'})
  t.is bd.val(), '20151231'
  t.is bd.add(), '20170102'

test 'reject with string 2', (t) ->
  bd = new bizday('20151231', {reject: ['2016', '01-02']})
  t.is bd.val(), '20151231'
  t.is bd.add(), '20170103'

test 'reject with regex', (t) ->
  bd = new bizday('20151231', {reject: [/2016/]})
  t.is bd.val(), '20151231'
  t.is bd.add(), '20170102'

test 'reject with regex (not array)', (t) ->
  bd = new bizday('20151231', {reject: /2016/})
  t.is bd.val(), '20151231'
  t.is bd.add(), '20170102'

test 'reject with regex 2', (t) ->
  bd = new bizday('20151231', {reject: [/01-01/, /01-02/]})
  t.is bd.val(), '20151231'
  t.is bd.add(), '20160104'

test 'reject with regex and string', (t) ->
  bd = new bizday('20151231', {reject: [/2016/, '01-02', /01-03/]})
  t.is bd.val(), '20151231'
  t.is bd.add(), '20170104'
