_ = require('lodash-core')
bizday = require('../')
moment = require 'moment'
{test} = require 'ava'

test 'buildCalendar()', (t) ->
  t.true bizday.buildCalendar().length >= 365
test 'buildCalendar("notObject")', (t) ->
  e = t.throws -> bizday.buildCalendar("notObject")
  t.is e.message, 'Argument requires object type'
test 'buildCalendar(opts)', (t) ->
  opts =
    startYear: 2016
    endYear: 2017
  t.true bizday.buildCalendar(opts).length is 731
test 'buildCalendar(omitWeekEnd)', (t) ->
  opts =
    startYear: 2016
    endYear: 2017
    omitWeekEnd: true
  t.true bizday.buildCalendar(opts).length is 521
test 'buildCalendar(Invalid value)', (t) ->
  opts =
    startYear: 'Invalid'
    endYear: 'value'
  t.true bizday.buildCalendar(opts).length >= 365