# Tacokit

Ruby toolkit for the Trello API. Design and philosophy
inspired by [ocktokit.rb](https://github.com/ocktokit/ocktokit.rb)

This is Taco.

![Taco][taco]
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

Generate your TRELLO_APP_KEY and TRELLO_APP_SECRET [here][appkey].
[appkey]: https://tacokit.herokuapp.com

You can also access your app key and secret from the command line (with
`launchy` installed):

```ruby
Tacokit.generate_app_key

Tacokit.configure do |c|
  c.app_key    = "4ppk3y"
  c.app_secret = "4pps3cr3t"
end
```

[API methods][] are available as module methods (consuming module-level
configuration) or as client instance methods.

```ruby
# Fetch youself
Tacokit.member

# Fetch another member
Tacokit.member('tacokit')

# or

# Provide authentication credentials
client = Tacokit::Client.new(app_key: '4ppk3y', app_secret: '4pps3cr3t!')

# Fetch a member
client.member('tacokit')
```
## Acquiring OAuth Credentials

The Trello API provides OAuth 1.0 credentials through the typical OAuth web
flow.

To expedite use of OAuth tokens for development, try out the [Tacokit
Sandbox](sandbox). With a valid credentials, both the `TRELLO_APP_KEY` and
`TRELLO_APP_SECRET` acquired via Trello

[sandbox](https://tacokit.herokuapp.com)
## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( https://github.com/[my-github-username]/Tacokit/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
