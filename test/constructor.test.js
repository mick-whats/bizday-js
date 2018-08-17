// Generated by CoffeeScript 2.3.1
(function() {
  var _, bizday, moment, test;

  _ = require('lodash');

  bizday = require('../');

  moment = require('moment');

  ({test} = require('ava'));

  test('bizday', function(t) {
    var bd;
    bd = new bizday();
    return t.is(bd.val(), moment().format('YYYYMMDD'));
  });

  test('bizday with format', function(t) {
    var bd;
    bd = new bizday(null, {
      format: 'YYYY-MM-DD'
    });
    return t.is(bd.val(), moment().format('YYYY-MM-DD'));
  });

  test('bizday with type is jp', function(t) {
    var bd;
    bd = new bizday(null, {
      type: 'jp'
    });
    return t.false(_.includes(bd.list, '2018-05-03'));
  });

}).call(this);