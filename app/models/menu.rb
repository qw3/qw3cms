# -*- encoding : utf-8 -*-
class Menu < ActiveRecord::Base

  include BrHelper

  has_many :item_menu, :dependent => :destroy
  
  validates :alias, :uniqueness => true
  
  before_save :montar_alias
  
  def montar_alias
    self.alias = create_alias self.alias, self.nome
  end
end
