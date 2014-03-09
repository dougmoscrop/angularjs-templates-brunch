# Compile templates in an AngularJS module as a Brunch plugin

For each template, wrap around in a shared AngularJS module called
`templates` by default with each template file's path as the template URL.
See [$templateCache](http://docs.angularjs.org/api/ng.$templateCache) for more
information.


## Installation

`npm install --save angularjs-templates-brunch`


## Usage

  1. Set `joinTo` attribute for `templates` in `config.coffee`, e.g.

	```coffee
	templates:
	  joinTo:
		'templates.js': /^app/
	```

  2. In your markup, include `templates.js`:

	```html
	<script type="text/javascript" src="/templates.js"></script>
	```

  3. Your app module must require the module your templates were placed in:

	```coffee
	angular.module('MyApp', [
	  ...
	  'templates'
	  ...
	]);
	```

  4. Get a particular template by its path.

	```coffee
	$routeProvider.when('/home', { templateUrl: 'app/home/home.html' });
	```

  5. Run Brunch (e.g. `brunch build`)


## Options

### module

Specify the module to place the templates in

Default: `templates`

```coffee
plugins:
  angular_templates:
    module: 'MyModule'
```

## Credit

I looked at and used parts from these projects:

- https://github.com/nathanredblur/html-angularjs-brunch
- https://github.com/kenhkan/angular-templates-brunch/