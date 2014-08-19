class AddHstoreExtension < ActiveRecord::Migration
  unless Rails.env.production?
    def up
      execute 'CREATE EXTENSION hstore'
    end

    def down
      execute 'DROP EXTENSION hstore'
    end
  end
end
