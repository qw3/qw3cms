# -*- encoding : utf-8 -*-
class ItemMenu < ActiveRecord::Base
  
  include BrHelper
  
  belongs_to :menu
  
  validates :alias, :uniqueness => true
  
  before_save :montar_alias
  
  before_create :atribuir_ordem
  
  def montar_alias
    self.alias = create_alias self.alias, self.nome
  end
  
  def atribuir_ordem
    if ItemMenu.count.zero?
      self.ordem = 1
    else
      self.ordem = ItemMenu.last.ordem + 1
    end
  end
end
