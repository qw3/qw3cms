# -*- encoding : utf-8 -*-
class CreateCategoriasPagina < ActiveRecord::Migration
  def self.up
    create_table :categorias_pagina do |t|
      t.string :nome
      t.string :alias

      t.timestamps
    end
  end

  def self.down
    drop_table :categorias_pagina
  end
end
