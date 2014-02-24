module.exports = class AngularTemplatesCompiler
  brunchPlugin: yes
  type: 'template'
  extension: 'html'

  constructor: (config) ->
    @module = config.plugins?.angular_templates?.module or 'templates'
  
  parseHtml: (str) ->
    return str.replace(/'/g, "\\'").replace(/\r?\n/g, '')
  
  compile: (data, path, callback) ->
    html = @parseHtml(data)
    url = path.replace(/\\/g, "/")
    
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

    module.run(function($templateCache) {
        $templateCache.put('#{url}', '#{html}');
    });
})();
"""
