escape = require('js-string-escape');

module.exports = class AngularTemplatesCompiler
  brunchPlugin: yes
  type: 'template'
  extension: 'html'

  _default_path_transform: (path) ->
    # Default path transformation is a no-op
    path

  constructor: (config) ->
    @module = config.plugins?.angular_templates?.module or 'templates'
    @path_transform = config.plugins?.angular_templates?.path_transform or @_default_path_transform

  compile: (data, path, callback) ->
    html = escape(data)
    url = @path_transform(path.replace(/\\/g, "/"))

    callback null, """
(function() {
    var module;

    try {
        // Get current templates module
        module = angular.module('#{@module}');
    } catch (error) {
        // Or create a new one
        module = angular.module('#{@module}', []);
    }

    module.run(["$templateCache", function($templateCache) {
        $templateCache.put('#{url}', '#{html}');
    }]);
})();
"""
