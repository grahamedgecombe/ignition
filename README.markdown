Ignition
========

Ignition is a [Rails][1] [engine][2] which routes and renders your
application's static pages.

Installation
------------

It takes three easy steps to install Ignition:

  1. Add `gem 'ignition'` to your `Gemfile` and run the `bundle` command.

  2. Mount Ignition's engine in your `config/routes.rb` file:

         mount Ignition::Engine => '/pages'

  3. Create pages like normal templates in the `app/views/pages` directory. Use
     any format and template handler you like. They'll be available at
     `/pages/name`.

Features
--------

  * Caching

  * Secure - you cannot include pages outside of the `app/views/pages` directory

  * Nested pages - e.g. `http://my.app/pages/projects/hello` would load the
    template `app/views/projects/hello.html.erb`

  * Mountable at any path - e.g. you could mount to `/` if you wanted pages
    like `/about`, this will not conflict with your existing routes even if
    Ignition is mounted before your define the routes

  * URL helpers - use `ignition_engine.page_path` and
    `ignition_engine.page_url` to link to your static pages.

  * Works with custom (and multiple) `app/views` paths.

Configuration
-------------

### Caching

By default Ignition does not perform any caching, as this can interfere with
the application's layout.

There are three types of caching:

  * **`:none`** - does not perform any caching (default).

  * **`:page`** - caches the entire page using Rails' [page caching][3].

  * **`:page_without_layout`** - caches the page using Rails'
    [action caching][4]. The layout is not included in the cache, therefore
    this option is useful if your layout is dynamic.

These can be set in the `config/application.rb` file or any of the
`config/environments/*.rb` files, like so:

    config.ignition.cache = :page

### Layout

By default Ignition will make your static pages use the `application` layout.
This is also the Rails default. It can be changed like so in the
`config/application.rb` file:

    config.ignition.layout = 'my_page_layout'

### View Prefix

By default Ignition will try to include pages in a folder named `pages` inside
your `app/views` folder. You can change this `pages` prefix by changing the
following stting inside the `config/application.rb` file:

    config.ignition.view_prefix = 'static_pages'

The only reason you would probably want to do this is if `pages` conflicts with
a controller and set of views you already have.

Tips
----

### Avoid typing `ignition_engine.` in front of URL helpers

This can be accomplished by placing the following code in your
`ApplicationHelper` module, found in the `app/helpers/application_helper.rb`
file:

    [:page_path, :page_url].each do |method|
      define_method(method) do |*args|
        ignition_engine.send(method, *args)
      end
    end

License
-------

Ignition is available under the MIT license, see the `LICENSE` file.

[1]: http://www.rubyonrails.org
[2]: http://api.rubyonrails.org/classes/Rails/Engine.html
[3]: http://guides.rubyonrails.org/caching_with_rails.html#page-caching
[4]: http://guides.rubyonrails.org/caching_with_rails.html#action-caching

