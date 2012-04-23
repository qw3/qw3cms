# -*- encoding : utf-8 -*-
class PaginasController < FrontendController

  def show
    @pagina = Pagina.find( params[:id] )
    @pagina.palavras_chave = "" if @pagina.palavras_chave.blank?
    
    meta :title => "#{Settings["LOJA.titulo"]} | #{@pagina.titulo_pagina}",
         :description => @pagina.descricao,
         :keywords => @pagina.palavras_chave.gsub(";", ",") 
    
    respond_to do |format|
      format.html #show.html.erb
    end
  end

end
