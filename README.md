# Tacokit

Ruby toolkit for the Trello API... a work-in-progress. Design and philosophy
inspired by [ocktokit.rb](https://github.com/ocktokit/ocktokit.rb)

This is Taco.

![Taco][taco]
[taco]: http://cl.ly/image/2p1x3K1X160b/taco.png

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tacokit'
```

... or install it yourself as:

    $ gem install tacokit

### Quick Start

[Generate][appkey] your TRELLO_APP_KEY and TRELLO_APP_SECRET].
[appkey]: https://tacokit.herokuapp.com

You can also access your app key and secret from the command line with
`launchy` installed: `Tacokit.generate_app_key`

Use these credentials to configure your app client:

```ruby
Tacokit.configure do |c|
  c.app_key    = "4ppk3y"
  c.app_secret = "4pps3cr3t"
end
```

API methods are available as module methods (consuming module-level
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

To acquire OAuth tokens for development, visit the [Tacokit
Sandbox](sandbox) and enter your `TRELLO_APP_KEY` and `TRELLO_APP_SECRET`,

[sandbox]: https://tacokit.herokuapp.com

## Usage

Coming soon.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/tacokit/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
