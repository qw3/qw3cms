# -*- encoding : utf-8 -*-
class ItemMenu < ActiveRecord::Base
  belongs_to :menu
  
  validates :alias, :uniqueness => true
end
