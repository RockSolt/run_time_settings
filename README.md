[![Gem Version](https://badge.fury.io/rb/run_time_settings.svg)](https://badge.fury.io/rb/run_time_settings)
![RSpec](https://github.com/RockSolt/run_time_settings/workflows/RSpec/badge.svg)
![RuboCop](https://github.com/RockSolt/run_time_settings/workflows/RuboCop/badge.svg)
[![Maintainability](https://api.codeclimate.com/v1/badges/73c3c733ef1f3173fff3/maintainability)](https://codeclimate.com/github/RockSolt/run_time_settings/maintainability)

# RunTimeSettings

Run time is the most important part. If you're okay with doing a deployment to update a setting, then that sounds like an environment variable (for which there are lots of good solutions). However, if you find yourself wanting to change a value more frequently, or you want someone without the ability to do a deployment to be able to change a value, then run-time settings might be for you.

In the end these are just namespaced key-value pairs stored in the database. You could create a settings model (and we do!) with a key attribute and a value attribute and you'd have just about the same thing. But it's ruby and it's rails, so you want a few more features from your settings:

- type castings so that 'true' returns true and '42' return 42
- default values
- predicate methods for boolean settings

## Usage

Settings can be declared on any class—a PORO or an ActiveRecord can declare settings.

```ruby
class BatchJob
  setting :last_run, :date
  setting :enabled, :boolean, default: false
  setting :percentage, :float
end
```

The settings are then available via accessors on the class:

```ruby
BatchJob.last_run = Date.today
BatchJob.enabled?
BatchJob.percentage
```

### Types

The following types are available to use:
- big_integer
- boolean
- date
- datetime
- decimal
- float
- integer
- string
- time

Note: The <tt>time</tt> type does not store milliseconds.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'run_time_settings'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install run_time_settings

### Migration for `run_time_settings` Table

The table must be created before settings can be used. Run the following command to generate a migration for the `run_time_settings` table:

    rails g migration CreateRunTimeSettings namespace:string key_name:string db_value:string

It should generate a migration that looks something like this:

```ruby
class CreateRunTimeSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :run_time_settings do |t|
      t.string :namespace
      t.string :key_name
      t.string :db_value
      t.timestamps
    end
  end
end
```


## Development

Guard runs both [RuboCop](https://docs.rubocop.org/en/stable/) and [RSpec](https://relishapp.com/rspec). Rubocop is
configured to auto-correct safe issues.

Start [Guard](https://github.com/guard/guard) at the command line: `bundle exec guard`

Both can be run manually from the command line:

`rubocop`

`bundle exec rspec`

Run the console with the following:

`bundle exec rake console`

### Database

The tests (and the console) use an in-memory database, so there is no prior setup required. It gets created each time.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/RockSolt/run_time_settings. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/RockSolt/run_time_settings/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RunTimeSettings project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/RockSolt/run_time_settings/blob/master/CODE_OF_CONDUCT.md).
