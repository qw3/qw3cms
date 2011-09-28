# -*- encoding : utf-8 -*-
class Pagina < ActiveRecord::Base
  belongs_to :categoria_pagina
  
  validates :titulo, :conteudo, :categoria_pagina, :presence => true
  attr_accessor :conteudo
  
  def introtext
    html_splitted = self.conteudo.split '<hr />'
    # não encontrou page break
    if html_splitted.count < 2
      # busca o primeiro elemento com o nokogiri
      doc = Nokogiri::HTML self.conteudo
      return doc.xpath('/html/body/*').first.text
    end
    
    return html_splitted[0]
  end
  
end
