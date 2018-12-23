_ = require('lodash-core')
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
  bd = new bizday('2018-05-01', {format: 'L'})
  t.is bd.val(), '05/01/2018'

test 'OutRangeError ', (t) ->
  e = t.throws -> new bizday('1901-01-01')
  t.is e.message, 'The valid range is from 2000-01-01 to 2030-12-31'

test 'add()', (t) ->
  bd = new bizday('2018-05-01')
  t.is bd.val(), '2018-05-01'
  t.is bd.add(), '2018-05-02'
  t.is bd.add(), '2018-05-03'
  t.is bd.add(), '2018-05-04'
  t.is bd.add(), '2018-05-07'
  t.is bd.val(), '2018-05-07'

test 'add() OutRangeError ', (t) ->
  bd = new bizday('2030-12-31')
  e = t.throws -> bd.add()
  t.is e.message, 'The valid range is from 2000-01-01 to 2030-12-31'

test 'add() start is sunday', (t) ->
  bd = new bizday('2018-05-06')
  t.is bd.val(), '2018-05-06'
  t.is bd.add(), '2018-05-07'
  t.is bd.add(), '2018-05-08'
  t.is bd.val(), '2018-05-08'

test 'add() start is saturday', (t) ->
  bd = new bizday('2018-05-05')
  t.is bd.val(), '2018-05-05'
  t.is bd.add(), '2018-05-07'
  t.is bd.add(), '2018-05-08'
  t.is bd.val(), '2018-05-08'

test 'add(count)', (t) ->
  bd = new bizday('2018-05-01')
  t.is bd.val(), '2018-05-01'
  t.is bd.add(2), '2018-05-03'
  t.is bd.add(2), '2018-05-07'
  t.is bd.val(), '2018-05-07'

test 'sub()', (t) ->
  bd = new bizday('2018-05-01')
  t.is bd.val(), '2018-05-01'
  t.is bd.sub(), '2018-04-30'
  t.is bd.sub(), '2018-04-27'
  t.is bd.sub(), '2018-04-26'
  t.is bd.val(), '2018-04-26'

test 'sub() start date is sunday', (t) ->
  bd = new bizday('2015-11-15')
  t.is bd.val(), '2015-11-15'
  t.is bd.sub(), '2015-11-13'
  t.is bd.sub(), '2015-11-12'
  t.is bd.sub(), '2015-11-11'
  t.is bd.val(), '2015-11-11'

test 'sub(count)', (t) ->
  bd = new bizday('2018-05-01')
  t.is bd.val(), '2018-05-01'
  t.is bd.sub(2), '2018-04-27'
  t.is bd.sub(2), '2018-04-25'
  t.is bd.sub(2), '2018-04-23'
  t.is bd.val(), '2018-04-23'

test 'sub() OutRangeError ', (t) ->
  bd = new bizday('2000-01-01')
  e = t.throws -> bd.sub()
  t.is e.message, 'The valid range is from 2000-01-01 to 2030-12-31'

test 'add() with jp-holiday', (t) ->
  # add option key 'type' value of 'jp','jpn', 'JP', 'JPN'
  bd = new bizday('2018-05-01', {type: 'jp'})
  t.is bd.val(), '2018-05-01'
  t.is bd.add(), '2018-05-02'
  t.is bd.add(), '2018-05-07'
  t.is bd.add(), '2018-05-08'

test 'add(count) with jp-holiday', (t) ->
  bd = new bizday('2018-05-01', {type: 'jp'})
  t.is bd.val(), '2018-05-01'
  t.is bd.add(2), '2018-05-07'
  t.is bd.add(2), '2018-05-09'

test 'sub() with jp-holiday', (t) ->
  bd = new bizday('2018-05-01', {type: 'JPN'})
  t.is bd.val(), '2018-05-01'
  t.is bd.sub(), '2018-04-27'
  t.is bd.sub(), '2018-04-26'
  t.is bd.sub(), '2018-04-25'

test 'sub(count) with jp-holiday', (t) ->
  bd = new bizday('2018-05-01', {type: 'JPN'})
  t.is bd.val(), '2018-05-01'
  t.is bd.sub(2), '2018-04-26'
  t.is bd.sub(2), '2018-04-24'
  t.is bd.sub(2), '2018-04-20'
