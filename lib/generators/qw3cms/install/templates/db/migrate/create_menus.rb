# -*- encoding : utf-8 -*-
class CreateMenus < ActiveRecord::Migration
  def self.up
    create_table :menus do |t|
      t.string :nome
      t.string :alias

      t.timestamps
    end
  end

  def self.down
    drop_table :menus
  end
end
