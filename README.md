# Tacokit

Ruby toolkit for the Trello API. Design and philosophy
inspired by [ocktokit.rb](https://github.com/ocktokit/ocktokit.rb)

This is Taco.

![Taco][togo]
[taco]: http://cl.ly/image/2p1x3K1X160b/taco.png

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tacokit'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tacokit

### Making requests

Generate a developer key and secret: https://trello.com/1/appKey/generate

```ruby
Tacokit.generate_app_key

Tacokit.configure do |c|
  c.app_key = "4ppk3y"
  c.app_secret = "4pps3cr3t"
end
```

[API methods][] are available as module methods (consuming module-level
configuration) or as client instance methods.

```ruby
# Fetch a user
Tacokit.user('rossta')

# or

# Provide authentication credentials
client = Tacokit::Client.new(app_key: '4ppk3y', app_secret: '4pps3cr3t!')
# Fetch a user
client.user('rossta')
```

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( https://github.com/[my-github-username]/Tacokit/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
