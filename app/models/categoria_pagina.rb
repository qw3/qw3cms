# -*- encoding : utf-8 -*-
class CategoriaPagina < ActiveRecord::Base
  
  include BrHelper
  
  has_many :paginas
  
  before_save :montar_alias
  
  def montar_alias
    self.alias = create_alias self.alias, self.nome
  end
  
end
