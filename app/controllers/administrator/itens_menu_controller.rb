# -*- encoding : utf-8 -*-
class Administrator::ItensMenuController < Administrator::AdminController
  
  before_filter :menus_menu_detalhes
  
  # GET /itens_menu
  # GET /itens_menu.xml
  def index

    # nunca mostra todos os menus ao mesmo tempo
    # se tiver vazio, mostra o primeiro menu
    if params[:menu_id].blank?
      params[:menu_id] = Menu.first.id
    end
    
    conditions = []
    conditions << "menu_id = #{params[:menu_id]}" unless params[:menu_id].blank?
    conditions << "nome LIKE '%#{params[:nome]}%'" unless params[:nome].blank?
    conditions << "publicado = #{params[:publicado]}" unless params[:publicado].blank?
    conditions << "item_menu_pai IS NULL"
    
    @itens_menu = ItemMenu.paginate :page => params[:page], :conditions => conditions.join(' AND '), :order => "ordem ASC"

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.xml { render :xml => @itens_menu }
    end
  end

  # GET /itens_menu/new
  # GET /itens_menu/new.xml
  def new
    @item_menu = ItemMenu.new
    @item_menu.menu_id = params[:menu_id]

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @item_menu }
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
        format.html { redirect_to(administrator_itens_menu_path(:menu_id => @item_menu.menu_id), :notice => 'Item de menu criado com sucesso.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /itens_menu/1
  # PUT /itens_menu/1.xml
  def update
    @item_menu = ItemMenu.find(params[:id])

    respond_to do |format|
      if @item_menu.update_attributes(params[:item_menu])
        format.html { redirect_to(administrator_itens_menu_path(:menu_id => @item_menu.menu_id), :notice => 'Item de menu atualizado com sucesso.') }
      else
        format.html { render :action => "edit" }
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
      format.xml { head :ok }
    end
  end
  
  def publicar
    @item_menu = ItemMenu.find(params[:id])
    @item_menu.publicado = !@item_menu.publicado
    @item_menu.save
    respond_to do |format|
      format.html { redirect_to(administrator_itens_menu_url) }
      format.xml { head :ok }
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
      format.xml { head :ok }
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
      format.xml { head :ok }
    end
  end
  
  def ordenar
    ids = params[:cid]
    if !ids.nil? and !ids.count.zero?
      item = ItemMenu.find ids.first
      if !params[:cima].nil? and params[:cima].to_i == 0
        item.ordem = item.ordem + 1
        # Menu possui pai?
        if !item.item_pai.blank?
          # Então precisamos pegar todos os filhos desse pai para atualizar corretamente o que estava depois
          item2 = ItemMenu.menus_desse_pai( item.item_pai ).where( :ordem => item.ordem ).first
        else
          # Como ele é pai, recupera todos os pais para possibilitar a atualizacao
          item2 = ItemMenu.menus_pai.where( :ordem => item.ordem ).first
        end
        # Se existir item2 então atualizamos a ordem dos dois, caso não exista, não devemos alterar a ordem pois
        # o item1 já é o ultimo
        if !item2.nil?
          item2.ordem = item2.ordem - 1
          item2.save
          item.save
        end
      else
        item.ordem = item.ordem - 1
        # Menu possui pai?
        if !item.item_pai.blank?
          # Então precisamos pegar todos os filhos desse pai para atualizar corretamente o que estava depois
          item2 = ItemMenu.menus_desse_pai( item.item_pai ).where( :ordem => item.ordem ).first
        else
          # Como ele é pai, recupera todos os pais para possibilitar a atualizacao
          item2 = ItemMenu.menus_pai.where( :ordem => item.ordem ).first
        end
        # Se existir item2 então atualizamos a ordem dos dois, caso não exista, não devemos alterar a ordem pois
        # o item1 já é o ultimo
        if !item2.nil?
          item2.ordem = item2.ordem + 1
          item2.save
          item.save
        end
      end
    end
    
    respond_to do |format|
      format.html { redirect_to(administrator_itens_menu_url) }
      format.xml { head :ok }
    end
  end
  
  def selecionar_link
    @categorias = Categoria.order( "nome ASC" )
    @paginas = Pagina.order( "titulo_artigo ASC" )
  
    respond_to do |format|
      format.html { render :partial => "selecionar_link"}
    end
  end
  
  def gerar_link
    @link = params[:link]
  
    respond_to do |format|
      format.js
    end
  end
end