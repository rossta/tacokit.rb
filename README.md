# Tacokit

[![Build Status](https://travis-ci.org/rossta/tacokit.rb.svg?branch=master)](https://travis-ci.org/rossta/tacokit.rb) [![Code Climate](https://codeclimate.com/github/rossta/tacokit.rb/badges/gpa.svg)](https://codeclimate.com/github/rossta/tacokit.rb) [![Dependency Status](https://gemnasium.com/rossta/tacokit.rb.svg)](https://gemnasium.com/rossta/tacokit.rb) [![Coverage Status](https://coveralls.io/repos/rossta/tacokit.rb/badge.svg)](https://coveralls.io/r/rossta/tacokit.rb)

Ruby toolkit for the Trello API... a work-in-progress. Design and philosophy
inspired by [ocktokit.rb](https://github.com/ocktokit/ocktokit.rb)

This is Taco.

![Taco](http://cl.ly/image/2p1x3K1X160b/taco.png)

## Quick Start

Add this line to your application's Gemfile:

```ruby
gem "tacokit"
```

... or install it yourself as:

```
$ gem install tacokit
```

Configure the client with public-read application credentials:

```ruby
# View an app key and secret on Trello
Tacokit.get_app_key

# Configure the client
Tacokit.configure do |c|
  c.app_key = "4ppk3y"
end
```

Make requests to Trello API methods using module-level configuration or as client instance methods.

```ruby
# Fetch the current member
Tacokit.member

# Fetch another member
Tacokit.member "tacokit"

# Configure a separate client
client = Tacokit::Client.new app_key: "4ppk3y"

# Fetch a member
client.member "tacokit"
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
Tacokit.authorize scope: %w[ read write account ], expiration: "30days"

# Authorize a custom application and a different app key
Tacokit.authorize name: "My Trello App", key: "4ppk3y2"

# Read only permissions for custom app forever
Tacokit.authorize scope: "read", expiration: "never", name: "My Trello App"
```

Your Tacokit client can now be configured to make requests:

```ruby
# Configure the client
Tacokit.configure do |c|
  c.app_key   = "4ppk3y"
  c.app_token = "4ppt0k3n"
end
```

More information is available in the [Trello docs](https://trello.com/docs/index.html).

### OAuth Authorization

The Trello API provides OAuth 1.0 credentials through the typical OAuth web
flow. Tacokit clients can therefore be configured separately to make requests on
behalf of different members:

```ruby
client = Tacokit::Client.new app_key: "4ppk3y", oauth_token: "04utht0k3n"
```

#### OAuth Tacokit Sandbox

To experiment with OAuth tokens for development, visit the [Tacokit
Sandbox](https://tacokit.herokuapp.com) and enter your Trello app key and app secret.

The sandbox (hosted over SSL on heroku) will perform the OAuth handshake and display OAuth credentials onscreen. In a real web app, you'd more likely associate these credentials with users in your database. Check out the source code for the sandbox on the [sandbox branch of this repository](https://github.com/rossta/tacokit.rb/tree/sandbox).

#### Resources

For more information on setting up Trello OAuth for your web application

* Using OmniAuth? Try adding [omniauth-trello](https://github.com/joshrowley/omniauth-trello)
* To roll your own, see how the sandbox works: [Tacokit sandbox source](https://github.com/rossta/tacokit.rb/blob/817691cbc6933e5bf2fac23d37e57cf7fdbbdf04/app.rb)
* Check out the [Trello OAuth docs](https://trello.com/docs/gettingstarted/oauth.html)

### Using ENV variables

Default Tacokit client values can be set by values in ENV:

```ruby
export TRELLO_APP_KEY=4ppk3y
export TRELLO_APP_SECRET=4pps3cr3t
export TRELLO_APP_TOKEN=4ppt0k3n
```

## Usage

All requests are called on instances of a `Tacokit::Client`. Most return a `Tacokit::Resource` object which behaves similar to an `OpenStruct`.

### Boards

Board endpoints typically take a board id, short url, or board resource as the first argument.

See the client [Board docs](https://rossta.net/tacokit.rb/Tacokit/Client/Board.html) for more details.

```ruby
# retrieve board resource by board id
board = client.board(board_id)
# => {:id=>"54...", :name=>"Work in Progress", ... }

# access card attributes by message sending
board.name
# => "Work in Progress"

# retrieve boards for client account
boards = client.boards
# => [{:id=>"54...", :name=>"Work in Progress", ... }, {...}]

# retrieve board for user 'rossta'
boards = client.boards("rossta")
# => [{:id=>"32...", :name=>"Tacokit Ideas", ... }, {...}]

# change board attributes
board = client.update_board(board, name: "TODO")
# => {:id=>"54...", :name=>"TODO", ... }

# retrieve lists for a board
client.lists(board)
# => [{:id=>"56...", :name=>"Blocked", ... }, {...}]

# retrieve cards for a board
client.board_cards(board)
# => [{:id# =>"56...", :name# =>"Another Card", ... }, {...}]

# add me to your card
client.add_board_member(board, 'rosskaff@gmail.com', 'Ross Kaffenberger')

# all you need is a name
client.create_board("All We Need is Love")
```

### Cards

Card endpoints typically take a card id, short url, or card resource as the first argument.

See the client [Card docs](https://rossta.net/tacokit.rb/Tacokit/Client/Card.html) for more details.

```ruby
# retrieve card by card id
card = client.card(card_id)
# => {:id# =>"12...", :name# =>"Call Mom", ... }

# access card attributes by message sending
card.name
# => "Call wife"

# change card attributes
card = client.update_card(card, name: "Wish List")
# => {:id# =>"12...", :name# =>"Wish List", ... }

# move card to another list
client.move_card(card, list_id: list_id)

# retrieve members assigned to card
client.card_members(card)

# attach by url or file path
client.attach_file(card, "https://pbs.twimg.com/media/CCKtnZmUsAEUAX2.jpg:large")

# add comment to a card
client.add_comment(card, "Nice jorb!")

# receive notifications for card updates
client.subscribe_to_card(card)

# send card into the abyss
client.archive_card(card)

# bring card back from the abyss
client.restore_card(card)
```

### Lists

List endpoints typically take a list id or list resource as the first argument.

See the client [List docs](https://rossta.net/tacokit.rb/Tacokit/Client/List.html) for more details.

```ruby
# retrieve list by a list id
list = client.list(list_id)
# => {:id=>"78...", :name=>"Ready", ... }

# access card attributes by message sending
list.name
# => "Ready"

# change list attributes
client.update_list(list, name: "Done")
# => {:id=>"78...", :name=>"Done", ... }

# add a new list to a board
client.create_list(board.id, "Finished")
# => {:id => "89...", :name=>"Finished", ... }

# send all list cards to the abyss
client.archive_list_cards(list)
```

### Members

Most of the client member endpoints take an optional member name as the first argument. In many cases, the name can be omitted where it is assumed to be the current member (also given as "me").

See the client [Member docs](https://rossta.net/tacokit.rb/Tacokit/Client/Member.html) for more details.

```ruby
# Retrieve current member
me = client.member
# => {:id=>"548a6696b3b9918beb144b07",
# :avatar_hash=>"cb0df45055bac84e7c5fb728e00e2015",
# :bio=>"Tacokit puts the Trello API on Ruby",
# ... }

# Also
me = client.member("me")
# => {:id=>"548a6696b3b9918beb144b07",
# :avatar_hash=>"cb0df45055bac84e7c5fb728e00e2015",
# :bio=>"Tacokit puts the Trello API on Ruby",
# ... }

# Another member
rossta = client.member("rossta")
# => {:id=>"4f079adc73668b244b1c099a",
# :avatar_hash=>"706e95e427f91670bf21eee6afccee90",
# :bio=>"I write about all things web on rossta.net",
# ... }

# Retrieve my open boards, just the short links and names,
boards = client.boards(filter: "open", fields: %w[name short_url])

# Retrieve rossta's public boards with the organization embedded
boards = client.boards("rossta", filter: "public", organization: true)

# retrieve cards for client account
cards = client.cards
# => [{:id=>"12...", :name=>"Call Mom", ... }, {...}]

# retrieve cards for user 'rossta'
cards = client.cards("rossta")
# => [{:id=>"34...", :name=>"Buy Milk", ... }, {...}]
```

### Search

See the client [Search docs](https://rossta.net/tacokit.rb/Tacokit/Client/Search.html) for more details.

```ruby
Tacokit.search("rossta")
# => {:options=>
# {:terms=>[{:text=>"rossta"}],
#   :modifiers=>[],
#   :model_types=>["actions", "cards", "boards", "organizations", "members"],
#   :partial=>false},
# :members=>
#  [{:id=>"4f079adc73668b244b1c099a",
#    :avatar_hash=>"706e95e427f91670bf21eee6afccee90",
#    ...}]
#  ...}
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/tacokit/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am "Add some feature"`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
