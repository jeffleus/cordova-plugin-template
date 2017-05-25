
var exec = require('cordova/exec');

var PLUGIN_NAME = 'MyCordovaPlugin';

var MyCordovaPlugin = {
  echo: function(phrase, cb) {
    exec(cb, null, PLUGIN_NAME, 'echo', [phrase]);
  },
  getDate: function(cb) {
    exec(cb, null, PLUGIN_NAME, 'getDate', []);
  },
  init: function(options, cb) {
    exec(cb, null, PLUGIN_NAME, 'init', [options]);
  },
  login: function(username, password, cb) {
    exec(cb, null, PLUGIN_NAME, 'login', [username,password]);
  }
};

module.exports = MyCordovaPlugin;
