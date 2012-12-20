# -*- encoding : utf-8 -*-
class ItemMenu < ActiveRecord::Base
  
  include BrHelper
  
  belongs_to :menu
  
  validates :link, :nome, :menu_id, :presence => true
  
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
  
  def link_corrigido
    if self.link[0] != '/'
      self.link = '/' + self.link
    end
    return self.link
  end

  def item_pai
    return ItemMenu.find_by_id(self.item_menu_pai)
  end

  def sub_itens
    return ItemMenu.where(:item_menu_pai => self.id)
  end

  def folha?
    return self.sub_itens.count.zero?
  end

  def descricao
    return "#{self.item_pai.descricao} - #{self.nome}" unless self.item_pai.nil?
    return self.nome
  end
  
end
