# -*- encoding : utf-8 -*-
class AddItemPaiToItemMenu < ActiveRecord::Migration
  def self.up
    add_column :itens_menu, :item_menu_pai, :integer
  end

  def self.down
    remove_column :itens_menu, :item_menu_pai
  end
end