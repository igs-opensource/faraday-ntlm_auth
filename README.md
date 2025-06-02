# Faraday NTLM Authentication

A simple Faraday middleware for NTLM authentication

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'faraday-ntlm_auth'
```

And then execute:

```shell
bundle install
```

Or install it yourself as:

```shell
gem install faraday-ntlm_auth
```

## Usage

```ruby
require 'faraday/ntlm_auth'

conn = Faraday.new(url: 'http://example.com') do |faraday|
  faraday.adapter :net_http_persistent, pool_size: 5, idle_timeout: 5 # Net HTTP persistent adapter is required for NTLM authentication
  faraday.request :ntlm_auth, auth: 'username', 'your_password', 'your_domain'
end

```


## Development

After checking out the repo, run `bin/setup` to install dependencies.

Then, run `bin/test` to run the tests.

To install this gem onto your local machine, run `rake build`.

To release a new version, make a commit with a message such as "Bumped to 0.0.2" and then run `rake release`.
See how it works [here](https://bundler.io/guides/creating_gem.html#releasing-the-gem).

## Contributing

Bug reports and pull requests are welcome on [GitHub](<%= github_uri %>).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
