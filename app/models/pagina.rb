# -*- encoding : utf-8 -*-
class Pagina < ActiveRecord::Base
  belongs_to :categoria_pagina
  
  validates :titulo, :conteudo, :categoria_pagina, :presence => true
end
