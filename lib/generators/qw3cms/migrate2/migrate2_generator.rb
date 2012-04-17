# -*- encoding : utf-8 -*-

require 'rails/generators'
require 'rails/generators/migration'

module Qw3cms
  module Generators
    class Migrate2Generator < Rails::Generators::Base
      
      include Rails::Generators::Migration
      
      source_root File.expand_path("../templates", __FILE__)
      
      # Implement the required interface for Rails::Generators::Migration.
      # taken from http://github.com/rails/rails/blob/master/activerecord/lib/generators/active_record.rb
      def self.next_migration_number(dirname)
        if ActiveRecord::Base.timestamped_migrations
          Time.now.utc.strftime("%Y%m%d%H%M%S").to_s
        else
          "%.3d" % (current_migration_number(dirname) + 1)
        end
      end
      
      def create_migrations
        if yes?( "Gerar migrations?" )
          migration_template 'db/migrate/add_item_pai_to_item_menu.rb', 'db/migrate/add_item_pai_to_item_menu.rb'
          # sleep( 1.0 ) # Espera 1 segundo para que o timestamp da proxima migration seja diferente
          rake('db:migrate')
        end
      end
            
    end
  end
end
