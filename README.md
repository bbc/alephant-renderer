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

This gem requires you to have at least one component, which has within it at least one view/template pair.

```bash
src
├── components
│   ├── weather
│   │   ├── models
│   │   │   ├── daily_summary.rb
│   │   │   ├── weekly_summary.rb
│   │   ├── templates
│   │   │   ├── daily_summary.mustache
│   │   │   ├── weekly_summary.mustache
```

> daily_summary.rb

```ruby
require 'alephant/renderer/views/html'
require 'date'

class DailySummary < Alephant::Renderer::Views::Html
  def temp
    @data[:time].round 0
  end

  def time
    DateTime.now.strftime "%d/%m/%Y %H:%M"
  end

  def summary
    @data[:summary].capitalize
  end
end
```

> daily_summary.mustache

```mustache
Weather for {{ time }}
{{ summary }} - {{ temp }}°
```

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

#### Example Application

The [alephant-publisher-request](https://github.com/BBC-News/alephant-publisher-request) gem is an example of an application which utilises this gem. Overview of process:

1. Receives request from user, via [Rack](http://rack.github.io/).
2. Fetches required data dynamically from a given API.
3. Renders specified component using data.
4. Returns rendered template.

## Translations

Currently there is a simple implementation of the [i18n](https://github.com/svenfuchs/i18n) library that allows templates to be translated.

### Setup

You need the following directory structure inside of the folder that relates to the `base_path`:

```bash
components
├── locale
│   ├── en.yml
│   ├── cy.yml
```

The yaml configs must have the extension `.yml`.

### Yaml structure

The yaml translations files must follow the following structure:

```yaml
en:
  template_name:
    key: 'foo'
    sub:
      key: 'bar'

  another_template:
    key: 'baz'
```

The first node is the language code, then the next set of nodes are the names of the templates files that the translations apply to. This allows you to just reference the translation key in the templates without prefixing the name of the template.

### Usage

For each translation, a seperate model and view is needed.

#### Model

A model should override the `locale` method:

```ruby
class TestModel < Alephant::Views::HTML
  def locale
      :cy
  end
end
```

#### Translations

The best approach with the templates when translations are needed, is to have a base template then a seperate one for each lanuage that's being translated.

In each view model, the following method is available for translations:

```ruby
t 'my_key'
```

#### Example

If we had a template called 'test_template.mustache' we would have the following in the model 'test_template.rb':

>test_template.rb

```ruby
def my_translation
  t 'key'
end
```

>test_template.mustache

```mustache
{{ my_translation }}
```

>locale/en.yml

```yaml
en:
  test_template:
    key: 'A translation!'
```

##### Other options

The `t()` method takes a second hash argument for accessing other I18n features. Below are a few of the more common uses of this argument.

By default, if the translation key doesn't exist then the translation key is used as the translation. You can override this behaviour and provide an explicit default:

```ruby
def my_translation
  t 'missing_key', default: 'Some default'
end
```

Plurality can also be handled, including support for languages with multiple pluralities. You would define your translation in the yaml file like this:

```yaml
en:
    test_template:
        pluralized_key:
            one: 'Singular string'
            other: 'Plural string'
```
and the code would look like:
```ruby
t 'pluralized_key', count: @num_of_things
```

You can force it to use a different locale if you need:
```ruby
t 'some_key', locale: :cy
```

You can use strings from another subsection of the translations. E.g. if your renderer was currently _myRenderer_ and your translations yaml looked like this:
```yaml
en:
    myRenderer:
        'some_key': 'some string'
    general:
        'another_key': 'another string'
```
You can do this in code:
```ruby
t 'another_key', scope: 'general'
```

You can do simple variable substitution, as often dynamic data can be in a different position in different strings. Your yaml might look like:
```yaml
en:
    myRenderer:
        'some_key': 'some %{insert} string'
```
and the code looks like:
```ruby
t 'some_key', insert: 'text inserted into a'
```

## Templates

The template engine is built into the Alephant::Views::HTML class. Create methods that correspond to variables, and they will become available to the template.

### Paths

There are two template paths in Alephant, the template path and the partials path. By default in HTML renderers, the template path is `../templates/` from your model, and the partials path is `../../lib/templates` from your model. You can change either of these pathing strategies by overridding the default renderer_engine instantiation.

```ruby
def renderer_engine
  partial_path = File.join(base_path, 'templates/')
  Alephant::Renderer::Engine::Mustache.new(base_path, template_name, partial_path)
end
```
In the above example, base_path is the parent of the current model folder, so this will make the partials path equal to the template path.


## Contributing

1. [Fork it!](http://github.com/bbc-news/alephant-renderer/fork)
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Create new [Pull Request](https://github.com/BBC-News/alephant-renderer/pulls).

Feel free to create an [issue](https://github.com/BBC-News/alephant-renderer/issues/new) if you find a bug.
