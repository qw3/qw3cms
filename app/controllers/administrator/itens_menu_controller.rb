# -*- encoding : utf-8 -*-
class Administrator::ItensMenuController < Administrator::AdminController
  
  before_filter :menus_menu_detalhes
  
  # GET /itens_menu
  # GET /itens_menu.xml
  def index
    
    conditions = []
    conditions << "menu_id = #{params[:menu_id]}" unless params[:menu_id].blank?
    conditions << "nome LIKE '%#{params[:nome]}%'" unless params[:nome].blank?
    conditions << "publicado = #{params[:publicado]}" unless params[:publicado].blank?
    
    @itens_menu = ItemMenu.paginate :page => params[:page], :conditions => conditions.join(' AND '), :order => "ordem ASC"

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
  
  def publicar 
    @item_menu = ItemMenu.find(params[:id])
    @item_menu.publicado = !@item_menu.publicado
    @item_menu.save
    respond_to do |format|
      format.html { redirect_to(administrator_itens_menu_url) }
      format.xml  { head :ok }
    end
  end
  
  def multi_remover
    
    ids = params[:cid]
    if !ids.nil? and !ids.count.zero?
      ids.each do |id|
        if !id.empty?
          item = ItemMenu.find(id)
          item.destroy
        end
      end
    end
    
    respond_to do |format|
      format.html { redirect_to(administrator_itens_menu_url) }
      format.xml  { head :ok }
    end
  end
  
  def multi_publicar 
    
    ids = params[:cid]
    if !ids.nil? and !ids.count.zero?
      ids.each do |id|
        if !id.empty?
          item = ItemMenu.find(id)
          item.publicado = params[:publicar]
          item.save
        end
      end
    end
    
    respond_to do |format|
      format.html { redirect_to(administrator_itens_menu_url) }
      format.xml  { head :ok }
    end
  end
  
  def ordenar
    ids = params[:cid]
    if !ids.nil? and !ids.count.zero?
      item = ItemMenu.find ids.first
      if !params[:cima].nil? and params[:cima].to_i == 0
        item.ordem = item.ordem + 1
        item2 = ItemMenu.find_by_ordem item.ordem
        if !item2.nil?
          item2.ordem = item2.ordem - 1
          item2.save
          item.save
        end
      else
        item.ordem = item.ordem - 1
        item2 = ItemMenu.find_by_ordem item.ordem
        if !item2.nil?
          item2.ordem = item2.ordem + 1
          item2.save
          item.save
        end
      end
    end
    
    respond_to do |format|
      format.html { redirect_to(administrator_itens_menu_url) }
      format.xml  { head :ok }
    end
  end
end
