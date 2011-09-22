# -*- encoding : utf-8 -*-
class Administrator::CategoriasPaginaController < Administrator::AdminController
  
  before_filter :paginas_menu_detalhes
  
  def index
    @categorias = CategoriaPagina.paginate :page => params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.xml  { render :xml => @categorias }
    end
  end

  def show
    @categoria = CategoriaPagina.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @categoria }
    end
  end

  def new
    @categoria = CategoriaPagina.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @categorias }
    end
  end

  def edit
    @categoria = CategoriaPagina.find(params[:id])
  end

  def create
    @categoria = CategoriaPagina.new(params[:categoria_pagina])

    respond_to do |format|
      if @categoria.save
        format.html { redirect_to(administrator_categorias_pagina_path, :notice => 'Categoria criada com sucesso.') }
        format.xml  { render :xml => @pagina, :status => :created, :location => @pagina }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pagina.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @categoria = CategoriaPagina.find(params[:id])

    respond_to do |format|
      if @categoria.update_attributes(params[:categoria_pagina])
        format.html { redirect_to(administrator_categorias_pagina_path, :notice => 'Categoria atualizada com sucesso.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @categorias.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @categoria = CategoriaPagina.find(params[:id])
    @categoria.destroy

    respond_to do |format|
      format.html { redirect_to(administrator_categorias_pagina_path) }
      format.xml  { head :ok }
    end
  end
end
