# -*- encoding : utf-8 -*-
module CmsHelper

	def itens_menu_options_for_select( me )
		query = "menu_id = #{me.menu_id} AND id != #{me.id}" unless me.new_record?
		query = "menu_id = #{me.menu_id}" if me.new_record?
		return options_for_select(ItemMenu.where(query).order('nome ASC').collect{ |m| [m.descricao, m.id] }, me.item_menu_pai)
	end

end
