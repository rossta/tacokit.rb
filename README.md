# Tacoshell

Ruby toolkit for the Trello API. Design and philosophy
inspired by [ocktokit.rb](https://github.com/ocktokit/ocktokit.rb)

This is Taco.

![Taco][togo]
[taco]: http://cl.ly/image/2p1x3K1X160b/taco.png

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tacoshell'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tacoshell

### Making requests

Generate a developer key and secret: https://trello.com/1/appKey/generate

[API methods][] are available as module methods (consuming module-level
configuration) or as client instance methods.

```ruby
# Provide authentication credentials
Tacoshell.configure do |c|
  c.login = 'rossta'
  c.password = 'f1n3tun3ds0u1!'
end

# Fetch the current user
Tacoshell.user
```
or

```ruby
# Provide authentication credentials
client = Tacoshell::Client.new(:login => 'defunkt', :password => 'c0d3b4ssssss!')
# Fetch the current user
client.user
```

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( https://github.com/[my-github-username]/tacoshell/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
