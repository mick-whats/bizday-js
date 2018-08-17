_ = require('lodash')
bizday = require('../')
moment = require 'moment'
{test} = require 'ava'



test 'build', (t) ->
  opts =
    startYear: 2018
    endYear: 2018
    # omitWeekEnd: tru
  calendar = bizday.buildCalendar(opts)
  t.is calendar.length, 365

test 'build omitWeekEnd', (t) ->
  opts =
    startYear: 2018
    endYear: 2018
    omitWeekEnd: true
  calendar = bizday.buildCalendar(opts)
  calendar.forEach (d)->
    t.true moment(d).format('ddd') isnt 'Sun'
    t.true moment(d).format('ddd') isnt 'Sat'
  t.is calendar.length, 261
  return

test 'bizday with format', (t) ->
  # Moment.js | Docs http://momentjs.com/docs/#/displaying/
  bd = new bizday('20180501', {format: 'L'})
  t.is bd.val(), '05/01/2018'

test 'OutRangeError ', (t) ->
  e = t.throws -> new bizday('1901-01-01')
  t.is e.message, 'The valid range is from 2000-01-01 to 2030-12-31'

test 'add()', (t) ->
  bd = new bizday('20180501')
  t.is bd.val(), '20180501'
  t.is bd.add(), '20180502'
  t.is bd.add(), '20180503'
  t.is bd.add(), '20180504'
  t.is bd.add(), '20180507'
  t.is bd.val(), '20180507'

test 'add() OutRangeError ', (t) ->
  bd = new bizday('20301231')
  e = t.throws -> bd.add()
  t.is e.message, 'The valid range is from 2000-01-01 to 2030-12-31'

test 'add() start is sunday', (t) ->
  bd = new bizday('20180506')
  t.is bd.val(), '20180506'
  t.is bd.add(), '20180507'
  t.is bd.add(), '20180508'
  t.is bd.val(), '20180508'

test 'add() start is saturday', (t) ->
  bd = new bizday('20180505')
  t.is bd.val(), '20180505'
  t.is bd.add(), '20180507'
  t.is bd.add(), '20180508'
  t.is bd.val(), '20180508'

test 'add(count)', (t) ->
  bd = new bizday('20180501')
  t.is bd.val(), '20180501'
  t.is bd.add(2), '20180503'
  t.is bd.add(2), '20180507'
  t.is bd.val(), '20180507'

test 'sub()', (t) ->
  bd = new bizday('20180501')
  t.is bd.val(), '20180501'
  t.is bd.sub(), '20180430'
  t.is bd.sub(), '20180427'
  t.is bd.sub(), '20180426'
  t.is bd.val(), '20180426'

test 'sub() start date is sunday', (t) ->
  bd = new bizday('20151115')
  t.is bd.val(), '20151115'
  t.is bd.sub(), '20151113'
  t.is bd.sub(), '20151112'
  t.is bd.sub(), '20151111'
  t.is bd.val(), '20151111'

test 'sub(count)', (t) ->
  bd = new bizday('20180501')
  t.is bd.val(), '20180501'
  t.is bd.sub(2), '20180427'
  t.is bd.sub(2), '20180425'
  t.is bd.sub(2), '20180423'
  t.is bd.val(), '20180423'

test 'sub() OutRangeError ', (t) ->
  bd = new bizday('20000101')
  e = t.throws -> bd.sub()
  t.is e.message, 'The valid range is from 2000-01-01 to 2030-12-31'

test 'add() with jp-holiday', (t) ->
  # add option key 'type' value of 'jp','jpn', 'JP', 'JPN'
  bd = new bizday('20180501', {type: 'jp'})
  t.is bd.val(), '20180501'
  t.is bd.add(), '20180502'
  t.is bd.add(), '20180507'
  t.is bd.add(), '20180508'

test 'add(count) with jp-holiday', (t) ->
  bd = new bizday('20180501', {type: 'jp'})
  t.is bd.val(), '20180501'
  t.is bd.add(2), '20180507'
  t.is bd.add(2), '20180509'

test 'sub() with jp-holiday', (t) ->
  bd = new bizday('20180501', {type: 'JPN'})
  t.is bd.val(), '20180501'
  t.is bd.sub(), '20180427'
  t.is bd.sub(), '20180426'
  t.is bd.sub(), '20180425'

test 'sub(count) with jp-holiday', (t) ->
  bd = new bizday('20180501', {type: 'JPN'})
  t.is bd.val(), '20180501'
  t.is bd.sub(2), '20180426'
  t.is bd.sub(2), '20180424'
  t.is bd.sub(2), '20180420'
