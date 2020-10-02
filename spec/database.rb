# frozen_string_literal: true

require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)

ActiveRecord::Schema.define do
  create_table :run_time_settings do |t|
    t.string :namespace
    t.string :key_name
    t.string :db_value
    t.timestamps
  end
end
