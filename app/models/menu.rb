# -*- encoding : utf-8 -*-
class Menu < ActiveRecord::Base
  has_many :item_menu, :dependent => :destroy
  
  validates :alias, :uniqueness => true
end
