# -*- encoding : utf-8 -*-
class ItemMenu < ActiveRecord::Base
  belongs_to :menu
  
  validates :alias, :uniqueness => true
  
  before_save :montar_alias
  
  def montar_alias
    if self.alias.nil? or self.alias.empty?
      self.alias = self.nome.sub( " ", "_" ).downcase
    end
  end
end
