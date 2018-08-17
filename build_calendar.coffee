# command example
# npm run buildCalendar -- 2019

Promise = require 'bluebird'
fs = Promise.promisifyAll(require("fs"))
YAML = require('yaml').default
moment = require 'moment'

bizday = require('./')
paths =
  omit_weekend: 'data/omit_weekend.json'
  holidays_jp: 'data/holidays_jp.json'
  bizday_jp: 'data/bizday_jp.json'

build_holiday = ->
  new Promise (resolve, reject)->
    fs.readFileAsync('./holidays.yml', 'utf8')
    .then (file) ->
      objects = YAML.parse(file)
      holidays = Object.keys(objects)
      fs.writeFileAsync(paths.holidays_jp, JSON.stringify(holidays, null,2))
      .then -> resolve(holidays)
    .catch(reject)

build_omit_weekend = ->
  new Promise (resolve, reject)->
    opts =
      startYear: 2000
      endYear: 2030
      omitWeekEnd: true
    calendar = bizday.buildCalendar(opts)
    console.info calendar
    fs.writeFileAsync(paths.omit_weekend, JSON.stringify(calendar, null,2))
    .then ()-> resolve(calendar)
    .catch(reject)

build_bizday_jp = ->
  new Promise (resolve, reject)->
    Promise.props({
      holidays_jp: build_holiday()
      omit_weekend: build_omit_weekend()
    })
    .then (result)->
      bizday_jp = _.difference(result.omit_weekend, result.holidays_jp)
      fs.writeFileAsync(paths.bizday_jp, JSON.stringify(bizday_jp, null,2))
      .then(resolve)
    .catch(reject)


build_bizday_jp()
  .then () ->
    console.info 'build done'
