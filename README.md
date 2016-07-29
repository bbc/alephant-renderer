# Alephant::Renderer

Render snippets of HTML/JSON using templates.

[![Build Status](https://travis-ci.org/BBC-News/alephant-renderer.png?branch=master)](https://travis-ci.org/BBC-News/alephant-renderer) [![Gem Version](https://badge.fury.io/rb/alephant-renderer.png)](http://badge.fury.io/rb/alephant-renderer)

## Installation

Add this line to your application's Gemfile:

    gem 'alephant-renderer'

And then execute:

    bundle

Or install it yourself as:

    gem install alephant-renderer

## Setup

Please see the wiki guide on [setting up a basic renderer](https://github.com/BBC-News/alephant-renderer/wiki/Setting-up-a-basic-renderer).

## Usage

```ruby
require 'alephant/renderer'
require 'json'

config = {
  :renderer_id => 'weather',
  :view_path   => 'src/components'
}

data = {
  :summary => 'Light rain starting tonight.',
  :temp    => '11.86'
}.to_json

Alephant::Renderer.create(
  config, data
).views['daily_summary'].render
```

**Note** - Within you application you will be most likely providing the *data* dynamically and thus will not require the JSON library.

## Documentation

We have a [wiki](https://github.com/BBC-News/alephant-renderer/wiki)!

#### Example Application

The [alephant-publisher-request](https://github.com/BBC-News/alephant-publisher-request) gem is an example of an application which utilises this gem. Overview of process:

1. Receives request from user, via [Rack](http://rack.github.io/).
2. Fetches required data dynamically from a given API.
3. Renders specified component using data.
4. Returns rendered template.

## Contributing

1. [Fork it!](http://github.com/bbc-news/alephant-renderer/fork)
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Create new [Pull Request](https://github.com/BBC-News/alephant-renderer/pulls).

Feel free to create an [issue](https://github.com/BBC-News/alephant-renderer/issues/new) if you find a bug.

## Coding standards

For any submission, please:
1. Run rubocop against it, using [these standards](https://github.com/BBC-News/rubocop-config)
2. Ensure all unit tests pass (these are also checked on pushing to your branch)
