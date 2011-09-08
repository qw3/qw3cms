# -*- encoding : utf-8 -*-
class Administrator::ItensMenuController < Administrator::AdminController
  
  before_filter :menus_menu_detalhes
  
  # GET /itens_menu
  # GET /itens_menu.xml
  def index
    
    conditions = ""
    if !params[:menu].nil? and !params[:menu][:id].nil? and !params[:menu][:id].empty?
      conditions = "menu_id = #{params[:menu][:id]}"
    end
    
    @itens_menu = ItemMenu.paginate :page => params[:page], :conditions => conditions

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.xml  { render :xml => @itens_menu }
    end
  end

  # GET /itens_menu/new
  # GET /itens_menu/new.xml
  def new
    @item_menu = ItemMenu.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @item_menu }
    end
  end

  # GET /itens_menu/1/edit
  def edit
    @item_menu = ItemMenu.find(params[:id])
  end

  # POST /itens_menu
  # POST /itens_menu.xml
  def create
    @item_menu = ItemMenu.new(params[:item_menu])

    respond_to do |format|
      if @item_menu.save
        format.html { redirect_to(administrator_itens_menu_path, :notice => 'Item de menu criado com sucesso.') }
        format.xml  { render :xml => @item_menu, :status => :created, :location => @item_menu }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @item_menu.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /itens_menu/1
  # PUT /itens_menu/1.xml
  def update
    @item_menu = ItemMenu.find(params[:id])

    respond_to do |format|
      if @item_menu.update_attributes(params[:item_menu])
        format.html { redirect_to(administrator_itens_menu_path, :notice => 'Item de menu atualizado com sucesso.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @item_menu.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /itens_menu/1
  # DELETE /itens_menu/1.xml
  def destroy
    @item_menu = ItemMenu.find(params[:id])
    @item_menu.destroy

    respond_to do |format|
      format.html { redirect_to(administrator_itens_menu_url) }
      format.xml  { head :ok }
    end
  end
end
