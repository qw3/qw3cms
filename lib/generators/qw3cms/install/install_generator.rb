# -*- encoding : utf-8 -*-

require 'rails/generators'
require 'rails/generators/migration'

module Qw3cms
  module Generators
    class InstallGenerator < Rails::Generators::Base
      
      include Rails::Generators::Migration
      
      source_root File.expand_path("../templates", __FILE__)
      
      def insert_gem
        gem "ckeditor"
      end
      
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
        migration_template 'db/migrate/create_categorias_pagina.rb', 'db/migrate/create_categorias_pagina.rb'
        migration_template 'db/migrate/create_paginas.rb', 'db/migrate/create_paginas.rb'
      end
      
      def create_ckeditor
        if yes? "Deseja instalar o ckeditor?"
          generate "ckeditor:install"
          gem "paperclip"        
          generate 'ckeditor:models --orm=active_record --backend=paperclip'
        end
        
        rake "db:migrate"
      end
      
      def create_routes
        if yes? "Deseja criar as rotas?"
          route "namespace :administrator do
            resources :menus
            resources :itens_menu
            resources :categorias_pagina
            resources :paginas
            controller :itens_menu do
              post 'itens_menu/buscar' => :index
            end
          end
          
          get 'paginas/show'\n"
          
          # Gerando rotas para ordenação
          generate "qw3common:routes administrator/itens_menu"
        end
      end
      
      def create_function_menu_detalhes
        inject_into_class 'app/controllers/administrator/admin_controller.rb', Administrator::AdminController do
          "def menus_menu_detalhes
            @detalhes_parcial = 'menus'
          end
          def paginas_menu_detalhes
            @detalhes_parcial = 'paginas'
          end\n"
        end
      end
      
      def insert_menu_calls
        inject_into_file "app/views/template/_leftbar.html.erb", :before => "</ul>" do
          "<%= render '/administrator/menus/leftbar_item' %>
          <%= render '/administrator/paginas/leftbar_item' %>\n"
        end
      end
      
      def append_menu_css
        append_file 'public/stylesheets/backend.css', do
          "#leftbar .menus-leftbar {\nbackground:url(\"../images/menu-icons/menus.png\") no-repeat scroll 10px padding-box transparent;\n}\n
          #leftbar .paginas-leftbar {\nbackground:url(\"../images/menu-icons/paginas.png\") no-repeat scroll 10px padding-box transparent;\n}\n"
        end
      end
      
      def copy_images
        copy_file "public/images/icons/itens-menu.png", "public/images/icons/itens-menu.png"
        copy_file "public/images/menu-icons/menus.png", "public/images/menu-icons/menus.png"
        copy_file "public/images/menu-icons/paginas.png", "public/images/menu-icons/paginas.png"
      end
      
      def copy_locales
        copy_file "config/locales/ckeditor.en.yml", "config/locales/ckeditor.en.yml"
        copy_file "config/locales/ckeditor.pt-BR.yml", "config/locales/ckeditor.pt-BR.yml"
      end
      
    end
  end
end
