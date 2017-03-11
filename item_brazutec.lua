if minetest.get_modpath("brazutec") and type(brazutec_laptop)=="table" then
	local imagem_para_enviar = "obj_mail.png";
	local etiqueta_para_enviar = "brazutec_abrirmsg";
	brazutec_instalar_em_cub(imagem_para_enviar,etiqueta_para_enviar)
	minetest.register_on_player_receive_fields(function(player, formname, fields)
		if fields.brazutec_abrirmsg then
			lunocartas.openinbox(player)
		end
	end)
end
