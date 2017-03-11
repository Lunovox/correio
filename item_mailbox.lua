modCorreio.mailbox = { }


modCorreio.openinbox = function(playername)
	--if player ~= nil and player:is_player() then
	if type(playername)=="string" and playername~="" then
		--local playername = player:get_player_name()
		if modCorreio.mailbox[playername]==nil or 
			modCorreio.mailbox[playername].selmail == nil or 
			type(modCorreio.mailbox[playername].selmail)~="number" or 
			modCorreio.mailbox[playername].selmail<0 
		then
			modCorreio.mailbox[playername] = { }
			modCorreio.mailbox[playername].selmail = 0
		end
		
		local formspecmails = modCorreio.get_formspecmails(playername) --<== Retorna os titulos das cartas em formato de formspec
		--minetest.log('action',"formspecmails = "..formspecmails)
		local formspec = "size[8,7.5]"
		.."label[2.75,0;CORREIO]"
		.."button_exit[0.5,7;1.5,0.5;closer;FECHAR]"
		.."button[2.0,7;1.5,0.5;openmail;ABRIR]"
		.."button[3.5,7;1.5,0.5;delmail;EXCLUIR]"
		.."button[5.0,7;1.5,0.5;clearmails;LIMPAR]"
		.."textlist[0,0.7;7.7,6;selmail;"..formspecmails..";"..modCorreio.mailbox[playername].selmail..";false]"
		
		minetest.show_formspec(playername,"modCorreio.mailbox",formspec)
	end
end

modCorreio.openmail = function(playername, mailnumber)
	--if player ~= nil and player:is_player() then
		--local playername = player:get_player_name()

	if type(playername)=="string" and playername~="" then
		local mail = modCorreio.get_mail(playername, mailnumber)
		if mail~=nil then
			--local formspecmails = modCorreio.get_formspecmails(playername)
			--minetest.log('action',"formspecmails = "..formspecmails)
			minetest.log('action',"[LUNOCARTAS] mail = "..dump(mail))
			local formspec = "size[8,7.5]"
			--.."label[2.75,0;MENSAGEM DE: "..mail.namefrom.."]"
			.."label[0.2,0;From: "..mail.namefrom.."]"
			.."button_exit[0.5,7;2,0.5;closer;FECHAR]"
			.."button[2.5,7;2,0.5;openinbox;VOLTAR]"
			.."button[4.5,7;2,0.5;delmail;EXCLUIR]"
			.."textarea[0.5,1.0;7.7,6.5;message;"..
			minetest.formspec_escape(os.date("%Y-%m-%d %Hh:%Mm:%Ss", mail.time))..";"..minetest.formspec_escape(mail.message).."]"
			--.."textlist[0,0.7;15.5,6;selmail;"..formspecmails..";1;false]"
		
			modCorreio.set_read(playername, mailnumber, true)
		
			minetest.show_formspec(playername,"modCorreio.mailbox",formspec)
		end
	end
end

minetest.register_on_player_receive_fields(function(sender, formname, fields)
	if formname == "modCorreio.mailbox"  then
		local playername = sender:get_player_name()
		minetest.log('action',"[LUNOCARTAS] fields = "..dump(fields))
		if fields.openinbox then
			minetest.log('action',"modCorreio.openinbox("..playername..")")
			modCorreio.openinbox(playername)
		elseif fields.selmail then
			local selnum = (fields.selmail):gsub("CHG:", "")
			minetest.log('action',"modCorreio.mailbox[playername].selmail="..dump(modCorreio.mailbox[playername].selmail))
			modCorreio.mailbox[playername].selmail = tonumber(selnum)
		elseif fields.openmail~=nil then
			if modCorreio.mailbox[playername].selmail~=nil and type(modCorreio.mailbox[playername].selmail)=="number" and modCorreio.mailbox[playername].selmail >=1 then
				minetest.log('action',"modCorreio.openmail["..playername.."].selmail="..dump(modCorreio.mailbox[playername].selmail))
				modCorreio.openmail(playername, modCorreio.mailbox[playername].selmail)
			else
				minetest.chat_send_player(playername, "Selecione a carta que deseja abrir!")
			end
		elseif fields.delmail~=nil then
			if modCorreio.mailbox[playername].selmail~=nil and type(modCorreio.mailbox[playername].selmail)=="number" and modCorreio.mailbox[playername].selmail >=1 then
				minetest.log('action',"modCorreio.del_mail("..playername..", "..modCorreio.mailbox[playername].selmail..")")
				modCorreio.del_mail(playername, modCorreio.mailbox[playername].selmail)
				modCorreio.openinbox(playername)
			else
				minetest.chat_send_player(playername, "Selecione a carta que deseja excluir!")
			end
		elseif fields.clearmails~=nil then
			minetest.log('action',"modCorreio.chat_delreadeds("..playername..")")
			modCorreio.chat_delreadeds(playername)
			modCorreio.openinbox(playername)
		end
	end
end)

local mailbox_format = {
	type = "fixed",
	fixed = { 
		{-.25,-.25,.5,			.25,.356,.45}
	}
}
local mailbox_tiles = {
	"tex_mailbox_topdown.png", --cima
	"tex_mailbox_topdown.png", --baixo
	"tex_mailbox_sides.png", --direita
	"tex_mailbox_sides.png".."^[transformFX", --esquerda
	"tex_mailbox_back.png", --traz
	"tex_mailbox_from.png", --frente
	--
}

minetest.register_node("correio:mailbox", {
	description = "Caixa de Correio (Exibe Cartas Recebida)",
	inventory_image = "obj_mailbox.png",
	--inventory_image = minetest.inventorycube("tex_light.png"),
	drawtype = "nodebox",
	paramtype = "light",
	--paramtype2 = "fixed",
	paramtype2 = "facedir",
	walkable = false,
	node_box =mailbox_format,
	selection_box = mailbox_format,
	tiles = mailbox_tiles,
	--sunlight_propagates = true,
	--light_source = LIGHT_MAX,
	is_ground_content = true, --Nao tenho certeza: Se prega no chao?
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2}, --{cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_wood_defaults(), --default.node_sound_glass_defaults(),
	after_place_node = function(pos, placer, itemstack)
		local meta = minetest.env:get_meta(pos)
		local owner = placer:get_player_name()
		meta:set_string("infotext", "Caixa de Correio de '"..owner.."'")
		meta:set_string("owner",owner)
	end,
	can_dig = function(pos, player)
		local meta = minetest.env:get_meta(pos)
		if meta~=nil then
			local ownername = meta:get_string("owner")
			local playername = player:get_player_name()
			if ownername~=nil and ownername~="" and ownername~=playername then
				minetest.chat_send_player(playername, "Voce nao pode destruir a caixa de correio de "..ownername..".")
				return false
			else
				return true
			end
		else
			return true
		end
	end,
	on_rightclick = function(pos, node, clicker, itemstack)
		local meta = minetest.env:get_meta(pos)
		if meta~=nil then
			local ownername = meta:get_string("owner")
			if ownername~=nil and ownername~="" then
				local clickername = clicker:get_player_name()
				if ownername==clickername then
					modCorreio.openinbox(ownername)
				else
					minetest.chat_send_player(clickername, "Esta caixa de correio pertece a '"..ownername.."'!")
				end
			end
		end
	end,
})

minetest.register_craft({
	output = 'correio:mailbox',
	recipe = {
		{"group:wood"	,"group:wood"			,"group:wood"},
		{"group:wood"	,"correio:papermail"	,"group:wood"},
		{"group:wood"	,"group:wood"			,"group:wood"},
	}
})

minetest.register_alias("mailbox"			,"correio:mailbox")
minetest.register_alias("correio"			,"correio:mailbox")
minetest.register_alias("caixacorreio"		,"correio:mailbox")
minetest.register_alias("caixadecorreio"	,"correio:mailbox")