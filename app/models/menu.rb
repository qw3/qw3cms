# -*- encoding : utf-8 -*-
class Menu < ActiveRecord::Base
  has_many :item_menu, :dependent => :destroy
  
  validates :alias, :uniqueness => true
  
  before_save :montar_alias
  
  def montar_alias
    if self.alias.nil? or self.alias.empty?
      self.alias = self.nome.sub( " ", "_" ).downcase
    end
  end
end
