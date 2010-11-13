# Ignition

![Ignition logo](https://github.com/grahamedgecombe/ignition/raw/master/doc/logo.png)

Static pages for Rails 3.

## Installation

Just execute the following command in the root directory of your Rails app:

    rails plugin install git://github.com/grahamedgecombe/ignition.git

## Usage

Put your pages in `RAILS_ROOT/app/views/pages`:

    mkdir app/views/pages
    echo "<h2>Hello World</h2>" > app/views/pages/hello.html.erb

Decide where you want static pages to be 'mounted', and add this to
`config/routes.rb`:

    static          # would map the page above to /hello
    static '/pages' # would map the page above to /pages/hello

Link to your pages like so:

    link_to 'Hello', page_path('hello')

Done!

## Configuration

Ignition can be configured by placing a call to Ignition::configure in an
initializer (e.g. `config/initializers/ignition.rb`) or an environment
configuration file (e.g. `config/environments/production.rb`).

    Ignition.configure do |config|
      # configuration entries here
    end

The following settings are currently supported:

### config.caching_method

You can configure caching using the `caching_method` setting.

`:page` uses the Rails page caching. `:page_without_layout` uses
action caching without the caching your application's layout. You can also set
it to `:none` for no caching to be performed (this is the default).

## Tips

If Ignition cannot find a page, it will set the `X-Cascade` header to
`pass` and set the response status to 404. This will cause the Rails
router to try the next rule(s). This cascade behaviour means that mapping
static pages to the root of your site won't stop you accessing everything else.

You can nest pages too! For example `/articles/i-love-rails` will map to
the `app/views/pages/articles/i-love-rails.html.erb` file. Don't
worry - Ignition performs some checks to make sure that people can't include
`/../../../../etc/passwd`, or any other file outside of the
`RAILS_ROOT/app/views/pages` directory.

Ignition still works if you change where the `views` directory is (or if
your application has multiple `views` directories).

## License

The logo was designed by Jonathan Edgecombe.

Copyright (c) 2010 Graham Edgecombe.
Released under the MIT license, see the `MIT-LICENSE` file for the terms.
