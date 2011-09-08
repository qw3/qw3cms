# -*- encoding : utf-8 -*-
class CreateItensMenu < ActiveRecord::Migration
  def self.up
    create_table :itens_menu do |t|
      t.string :nome
      t.string :alias
      t.string :link
      t.string :filtro
      t.integer :ordem
      t.references :menu

      t.timestamps
    end
  end

  def self.down
    drop_table :itens_menu
  end
end
