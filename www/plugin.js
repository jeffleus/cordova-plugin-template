
var exec = require('cordova/exec');

var PLUGIN_NAME = 'MyCordovaPlugin';

var MyCordovaPlugin = function(config, successCallback, errorCallback) {
	cordova.exec(function(params) {
		successCallback();
	},
	function(error) {
		errorCallback(error);
	}, "MyCordovaPlugin", "init", [config]);
};

MyCordovaPlugin.prototype.login = function(loginDetails, successCallback, errorCallback) {
    cordova.exec(successCallback, errorCallback
                 , PLUGIN_NAME, 'login', [loginDetails]);
};
               
MyCordovaPlugin.prototype.getToken = function(options, successCallback, errorCallback) {
    cordova.exec(successCallback, errorCallback
                 , PLUGIN_NAME, 'refresh', [options]);
};

module.exports = MyCordovaPlugin;
