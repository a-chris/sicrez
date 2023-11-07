# 🤫 Sicrez

Sicrez is the single entry point of access for your Rails Credentials, Settings (from the Config gem) and ENV variables.
It's just a small wrapper class so that you can store app secrets/settings wherever you prefer without the headache to figure out where they come from.

## Usage

```ruby
  # Rails.application.credentials.config.redis[:password] becomes
  Sicrez.redis.password

  # Rails.application.credentials.config.redis[:UPCASE_URL] becomes
  Sicrez.redis.upcase_url

  # Settings.app.name becomes
  Sicrez.app.name

  # ENV['SETUP_DB'] becomes
  Sicrez.setup_db
```

## Just why?

In my projects I have the habit to store the secrets/variables in different place:
- Rails Credentials for secrets/password/api keys that is better to keep in a safe place
- Settings files for everything else: urls, name, configurations, feature flags
- ENV variables for stuff that should take the precedence over everything else or that are set up by the system

This happened because I feel like the Rails Credentials are a bit hard to mantain and they could be overkill if you just put everything there: you get a big blob of encrypted text that you have to decrypt to change just a small string, for each one of your environments!

But storing all this stuff in different places comes with its cons:
you have to remember where they are stored and the code gets uglier because some places are calling `Rails.application.credentials.config` (a name so long should be illegal), some others `Settings` and `ENV`/

Here it comes **Sicrez**.

## Installation

Install this gem from github, I'm not distributing a release yet because it's a work in progress and it may receive several updates and fixes.
Give it a chance, I'm already running it for two of my projects in production.

Add to your Gemfile:

```
  gem "sicrez", github: "a-chris/sicrez", branch: "main"
```

No settings, configurations or initializers at the moment. Just install it and start using `Sicrez` to access your credentials.

## Features I'd like to add

I plan to had some neat feature in the future, like:
- raising an error during the startup of the server if a required variable is missing
- configurable secret sources and adding new ones
- configurable priority of the sources

## Known issues

Initialization is something I'm working on. It works without problems with `rails server` and `rails console` but is a pain while using capistrano do deploy your server, for example if you have some configurations accessed through Sicrez.

I'm still looking for the right place to require/load the gem in these cases.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/a-chris/sicrez. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/a-chris/sicrez/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Sicrez project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/a-chris/sicrez/blob/master/CODE_OF_CONDUCT.md).
