# -*- encoding : utf-8 -*-

require 'rails/generators'
require 'rails/generators/migration'

module Qw3cms
  module Generators
    class InstallGenerator < Rails::Generators::Base
      
      include Rails::Generators::Migration
      
      source_root File.expand_path("../templates", __FILE__)
      
      # Implement the required interface for Rails::Generators::Migration.
      # taken from http://github.com/rails/rails/blob/master/activerecord/lib/generators/active_record.rb
      def self.next_migration_number(dirname)
        if ActiveRecord::Base.timestamped_migrations
          Time.now.utc.strftime("%Y%m%d%H%M%S").to_s + rand(1230).to_s
        else
          "%.3d" % (current_migration_number(dirname) + 1)
        end
      end
      
      def create_migrations
        migration_template 'db/migrate/create_menus.rb', 'db/migrate/create_menus.rb'
        migration_template 'db/migrate/create_itens_menu.rb', 'db/migrate/create_itens_menu.rb'
        migration_template 'db/migrate/create_paginas.rb', 'db/migrate/create_paginas.rb'
      end
      
      def create_ckeditor
        generate "ckeditor_core"
        generate "ckeditor_models"
        
        rake "db:migrate"
      end
      
      def create_routes
        if yes? "Deseja criar as rotas?"
          route "namespace :administrator do
            resources :menus
            resources :itens_menu
            resources :paginas
            controller :itens_menu do
              post 'itens_menu/buscar' => :index
            end
          end"
          route "get paginas/show"
        end
      end
      
      def create_function_menu_detalhes
        inject_into_class 'app/controllers/administrator/admin_controller.rb', Administrator::AdminController do
          "def menus_menu_detalhes\n@detalhes_parcial = 'menus'\nend"
          "def paginas_menu_detalhes\n@detalhes_parcial = 'paginas'\nend"
        end
      end
      
    end
  end
end
