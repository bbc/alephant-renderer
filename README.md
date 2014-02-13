# Alephant::Renderer

Render HTML snippets

[![Build Status](https://travis-ci.org/BBC-News/alephant-renderer.png?branch=master)](https://travis-ci.org/BBC-News/alephant-renderer)

[![Gem Version](https://badge.fury.io/rb/alephant-renderer.png)](http://badge.fury.io/rb/alephant-renderer)

## Installation

Add this line to your application's Gemfile:

    gem 'alephant-renderer'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install alephant-renderer

## Usage

```rb
require 'alephant/renderer'

Alephant::Renderer.create('foo_template', '/base/path', 'foo_model')
```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/alephant-renderer/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
