# -*- encoding : utf-8 -*-
class Administrator::PaginasController < Administrator::AdminController
  
  before_filter :paginas_menu_detalhes
  
  # GET /paginas
  # GET /paginas.xml
  def index
    @paginas = Pagina.paginate :page => params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.xml  { render :xml => @paginas }
    end
  end

  # GET /paginas/1
  # GET /paginas/1.xml
  def show
    @pagina = Pagina.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pagina }
    end
  end

  # GET /paginas/new
  # GET /paginas/new.xml
  def new
    @pagina = Pagina.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pagina }
    end
  end

  # GET /paginas/1/edit
  def edit
    @pagina = Pagina.find(params[:id])
  end

  # POST /paginas
  # POST /paginas.xml
  def create
    @pagina = Pagina.new(params[:pagina])

    respond_to do |format|
      if @pagina.save
        format.html { redirect_to(administrator_paginas_path, :notice => 'Página criada com sucesso.') }
        format.xml  { render :xml => @pagina, :status => :created, :location => @pagina }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pagina.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /paginas/1
  # PUT /paginas/1.xml
  def update
    @pagina = Pagina.find(params[:id])

    respond_to do |format|
      if @pagina.update_attributes(params[:pagina])
        format.html { redirect_to(administrator_paginas_path, :notice => 'Página atualizada com sucesso.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pagina.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /paginas/1
  # DELETE /paginas/1.xml
  def destroy
    @pagina = Pagina.find(params[:id])
    @pagina.destroy

    respond_to do |format|
      format.html { redirect_to(administrator_paginas_path) }
      format.xml  { head :ok }
    end
  end
end
