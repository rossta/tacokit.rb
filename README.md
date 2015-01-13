# Tacokit

[![Build Status](https://travis-ci.org/rossta/tacokit.rb.svg?branch=master)](https://travis-ci.org/rossta/tacokit.rb) [![Code Climate](https://codeclimate.com/github/rossta/tacokit.rb/badges/gpa.svg)](https://codeclimate.com/github/rossta/tacokit.rb) [![Dependency Status](https://gemnasium.com/rossta/tacokit.rb.svg)](https://gemnasium.com/rossta/tacokit.rb)

Ruby toolkit for the Trello API... a work-in-progress. Design and philosophy
inspired by [ocktokit.rb](https://github.com/ocktokit/ocktokit.rb)

This is Taco.

![Taco][taco]
[taco]: http://cl.ly/image/2p1x3K1X160b/taco.png

## Quick Start

Add this line to your application's Gemfile:

```ruby
gem 'tacokit'
```

... or install it yourself as:

    $ gem install tacokit

Configure the client with public-read application credentials:

```ruby
# View an app key and secret on Trello
Tacokit.get_app_key

# Configure the client
Tacokit.configure do |c|
  c.app_key = '4ppk3y'
end
```

Make requests to Trello API methods using module-level configuration or as
client instance methods.
```ruby
# Fetch the current member
Tacokit.member

# Fetch another member
Tacokit.member 'tacokit'

# Configure a separate client
client = Tacokit::Client.new app_key: '4ppk3y'

# Fetch a member
client.member 'tacokit'
```
## Authentication

### Application Authorization

Trello supports application-level client authorization via an application key and application token.

Tacokit provides a simple way to retrieve your application key:

```ruby
# Install the `launchy` gem to load the Trello page automatically
Tacokit.get_app_key
```
Your application key are available by logging into Trello and visiting the [app key](https://trello.com/app-key) page. This page also provides your application secret that can be used to generate OAuth token access (see below).

The application token, generated separately from the app key, can be associated with a `scope` and `expiration`. See the Trello [authorization docs](https://trello.com/docs/gettingstarted/authorize.html) for more info on token params.

Tacokit provides a simple way to generate a new app token:

```ruby
# Full permissions for 30 days
Tacokit.authorize scope: %w[ read write account ], expiration: '30days'

# Authorize a custom application and a different app key
Tacokit.authorize name: 'My Trello App', key: '4ppk3y2'

# Read only permissions for custom app forever
Tacokit.authorize scope: 'read', expiration: 'never', name: 'My Trello App'
```

Your Tacokit client can now be configured to make requests:

```ruby
# Configure the client
Tacokit.configure do |c|
  c.app_key   = '4ppk3y'
  c.app_token = '4ppt0k3n'
end
```

More information is available in the [Trello docs](https://trello.com/docs/index.html).

### OAuth Authorization

The Trello API provides OAuth 1.0 credentials through the typical OAuth web
flow. Tacokit clients can therefore be configured separately to make requests on
behalf of different members:

```ruby
client = Tacokit::Client.new app_key: '4ppk3y', oauth_token: '04utht0k3n'
```

To experiment with OAuth tokens for development, visit the [Tacokit
Sandbox](https://tacokit.herokuapp.com) and enter your Trello app key and app secret.

#### Resources

For more information on setting up Trello OAuth for your web application

* Using OmniAuth? Try adding [omniauth-trello](https://github.com/joshrowley/omniauth-trello)
* To roll your own, see how the sandbox works: [Tacokit sandbox source](https://github.com/rossta/tacokit.rb/blob/heroku/app.rb)
* Check out the [Trello OAuth docs](https://trello.com/docs/gettingstarted/oauth.html)

### Using ENV variables

Default Tacokit client values can be set by values in ENV:

```shell
TRELLO_APP_KEY=4ppk3y
TRELLO_APP_SECRET=4pps3cr3t
TRELLO_APP_TOKEN=4ppt0k3n
```

## Usage

Coming soon.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/tacokit/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
