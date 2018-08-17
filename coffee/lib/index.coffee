_ = require 'lodash'
moment = require 'moment'
list =
  omit_weekend: require '../data/omit_weekend.json'
  holidays_jp: require '../data/holidays_jp.json'
  bizday_jp: require '../data/bizday_jp.json'


class OutRangeError extends RangeError
  constructor: (momentObject, list) ->
    first = list[0]
    last = _.last(list)
    super("The valid range is from #{first} to #{last}")
    @name = "OutRangeError"

rejectFromList = (list, rejectList) ->
  if _.isString(rejectList) or _.isRegExp(rejectList)
    rejectList = [rejectList]
  if _.isArray(rejectList)
    rejectList.forEach (rejectStr)->
      if _.isString(rejectStr)
        list = _.reject list, (listItem)-> listItem.includes(rejectStr)
      else if _.isRegExp(rejectStr)
        list = _.reject list, (listItem)-> listItem.match(rejectStr)
  return list

class BusinessDay
  @buildCalendar: (opts)->
    opts = opts or {}
    unless _.isPlainObject(opts)
      throw new Error('Argument requires object type')
    now = moment().format('YYYY')
    if opts.startYear and "#{opts.startYear}".match(/\d{4}/)
      startYear = opts.startYear
    else
      startYear = now
    if opts.endYear and "#{opts.endYear}".match(/\d{4}/)
      endYear = opts.endYear
    else
      endYear = now
    omitWeekEnd = opts.omitWeekEnd or false
    _format = 'YYYY-MM-DD'
    start = moment("#{startYear}-01-01")
    res = [start.format(_format)]
    loop
      start.add(1, 'day')
      lastYear = start.format(_format).match(/\d{4}/)[0]
      break if Number(endYear) < Number(lastYear)
      switch start.format('E')
        when '6', '7'
          if not omitWeekEnd
            res.push(start.format(_format))
        else
          res.push(start.format(_format))
      
    return res


  @isOutRange: (momentObject, list)->
    first = moment(list[0])
    last =  moment(_.last(list))
    if momentObject.isBefore(first) or momentObject.isAfter(last)
      return true
    else
      return false
  constructor: (day, @opts={}) ->
    if @opts.type?
      @list = switch @opts.type
        when 'jp','jpn', 'JP', 'JPN', 392
          list.bizday_jp
        when 'tse','TSE'
          _rejectList = [
            '12-31'
            '01-01'
            '01-02'
            '01-03'
          ]
          rejectFromList(list.bizday_jp, _rejectList)
        when 'Government','government','go','gov'
          _rejectList = [
            '12-29'
            '12-30'
            '12-31'
            '01-01'
            '01-02'
            '01-03'
          ]
          rejectFromList(list.bizday_jp, _rejectList)
        else
          list.omit_weekend
    else
      @list = list.omit_weekend
    if rejectList = @opts.reject
      @list = rejectFromList(@list, rejectList)

    @format = if @opts.format? then @opts.format else 'YYYYMMDD'
    @m = if day then moment(day) else moment()
    if BusinessDay.isOutRange(@m,@list)
      throw new OutRangeError(@m, @list)
  val: ->
    @m.format(@format)
  add: (count=1) ->
    nowDate = @m.format('YYYY-MM-DD')
    nowIndex = @list.indexOf(nowDate)
    count-- if nowIndex < 0
    while nowIndex < 0
      @m.add(1, 'day')
      nowDate = @m.format('YYYY-MM-DD')
      nowIndex = @list.indexOf(nowDate)
    newIndex = nowIndex + count
    unless @list[newIndex]
      throw new OutRangeError(@m, @list)
    @m = moment(@list[newIndex])
    return @m.format(@format)
  sub: (count=1) ->
    nowDate = @m.format('YYYY-MM-DD')
    nowIndex = @list.indexOf(nowDate)
    count-- if nowIndex < 0
    while nowIndex < 0
      @m.subtract(1, 'day')
      nowDate = @m.format('YYYY-MM-DD')
      nowIndex = @list.indexOf(nowDate)
    newIndex = nowIndex - count
    unless @list[newIndex]
      throw new OutRangeError(@m, @list)
    @m = moment(@list[newIndex])
    return @m.format(@format)
module.exports = BusinessDay
