# -*- encoding : utf-8 -*-
class Administrator::MenusController < Administrator::AdminController
  
  before_filter :menus_menu_detalhes
  
  # GET /menus
  # GET /menus.xml
  def index
    conditions = []
    conditions << "nome LIKE '%#{params[:menu_nome]}%'" unless params[:menu_nome].blank?
    @menus = Menu.paginate( :page => params[:page], :conditions => conditions.join(' AND '))

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  # GET /menus/new
  # GET /menus/new.xml
  def new
    @menu = Menu.new
    render :layout => false
  end

  # GET /menus/1/edit
  def edit
    @menu = Menu.find(params[:id])
    render :layout => false
  end

  # POST /menus
  # POST /menus.xml
  def create
    @menu = Menu.new(params[:menu])
    @menu.save

    respond_to do |format|
      format.js
    end
  end

  # PUT /menus/1
  # PUT /menus/1.xml
  def update
    @menu = Menu.find(params[:id])
    @menu.update_attributes(params[:menu])

    respond_to do |format|
      format.js
    end
  end

  # DELETE /menus/1
  # DELETE /menus/1.xml
  def destroy
    @menu = Menu.find(params[:id])
    @menu.destroy

    respond_to do |format|
      format.js
    end
  end
end
