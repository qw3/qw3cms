# -*- encoding : utf-8 -*-
class PaginasController < FrontendController

  def show
    @pagina = Pagina.find( params[:id] )
    
    respond_to do |format|
      format.html #show.html.erb
    end
  end

end
