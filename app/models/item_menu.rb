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
      if self.item_pai.blank?
        self.ordem = ItemMenu.menus_pai.last.ordem + 1
      else
        if ItemMenu.menus_desse_pai.blank or ItemMenu.menus_desse_pai.count == 0
          self.ordem = 1
        else
          self.ordem = ItemMenu.menus_desse_pai.last.ordem + 1
        end
      end
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
    return ItemMenu.where(:item_menu_pai => self.id).order( :ordem )
  end

  def folha?
    return self.sub_itens.count.zero?
  end

  def descricao
    return "#{self.item_pai.descricao} - #{self.nome}" unless self.item_pai.nil?
    return self.nome
  end

  # Retorna todos os menus que não tem filhos
  def self.menus_pai
    return ItemMenu.where( :item_menu_pai => nil )
  end

  # Retorna todos os menus filhos de um determinado pai
  def self.menus_desse_pai pai
    return nil if pai.blank?
    return ItemMenu.where( :item_menu_pai => pai )
  end
  
end
