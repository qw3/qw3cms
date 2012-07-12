# -*- encoding : utf-8 -*-
class PaginasController < FrontendController

  def show
    @pagina = Pagina.find( params[:id] )
    @pagina.palavras_chave = "" if @pagina.palavras_chave.blank?
    
    respond_to do |format|
      format.html #show.html.erb
    end
  end

end
