# Dachsfisch

[![Build Status](https://github.com/openHPI/dachsfisch/workflows/CI/badge.svg)](https://github.com/openHPI/dachsfisch/actions?query=workflow%3ACI)
[![codecov](https://codecov.io/gh/openHPI/dachsfisch/branch/master/graph/badge.svg?token=K267SFJO7S)](https://codecov.io/gh/openHPI/dachsfisch)

This gem offers a Ruby implementation of the [BadgerFish standard](http://www.sklar.com/badgerfish/), a set of rules for converting documents between the XML and JSON format. This gem supports conversion in both directions, specifically XML-to-JSON and JSON-to-XML.

The rules for converting XML documents to JSON using Badgerfish are:

- Element names become object properties.
- Text content of elements goes in the `$` property of an object.
- Nested elements become nested properties.
- Multiple elements at the same level become array elements.
- Attributes go in properties whose names begin with `@`.
- Active namespaces for an element go in the element's `@xmlns` property.
- The default namespace URI goes in `@xmlns.$`.
- Other namespaces go in other properties of `@xmlns`.
- Elements with namespace prefixes become object properties, too.
- The `@xmlns` property goes only in objects relative to the tag where namespace was declared.
- Text fragments in mixed contents (tags and text) become properties named `$1`, `$2`, etc.
- Comment tags, similar to text fragments, become properties named `!1`, `!2`, etc.
- CDATA sections become properties named `#1`, `#2`, etc.

Please see our [examples](spec/support/examples.rb) for more details. Those rules are derived from [this list](http://dropbox.ashlock.us/open311/json-xml/).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dachsfisch', github: 'openHPI/dachsfisch'
```

And then execute:

```
$ bundle
```

Note: Removing support for ancient Ruby or Rails versions will not result in a new major. Please be extra careful when using ancient Ruby or Rails versions and updating gems.

## Usage

Based on the desired conversion, use one of the following classes. In both cases, the input is expected to be a valid string.

### XML-to-JSON

```ruby
xml = '<alice>bob</alice>'
json = Dachsfisch::XML2JSONConverter.new(xml: xml)
```

### JSON-to-XML

```ruby
json = '{ "alice": { "$" : "bob" } }'
xml = Dachsfisch::JSON2XMLConverter.new(json: json)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/openHPI/dachsfisch. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/openHPI/dachsfisch/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in this project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/openHPI/dachsfisch/blob/master/CODE_OF_CONDUCT.md).
