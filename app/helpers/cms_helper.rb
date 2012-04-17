# -*- encoding : utf-8 -*-
module CmsHelper

	def itens_menu_options_for_select( me )
		return options_for_select(ItemMenu.where("menu_id = #{me.menu_id} AND id != #{me.id}").order('nome ASC').collect{ |m| [m.descricao, m.id] }, me.item_menu_pai)
	end

end
