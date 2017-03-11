modCorreio.openpapermail = function(playername)
	--if player~=nil and player:is_player() then
	if type(playername)=="string" and playername~="" then
		--local playername = player:get_player_name()
		if modCorreio.mailbox[playername]==nil then
			modCorreio.mailbox[playername] = { }
			modCorreio.mailbox[playername].selmail = 0
		end
		
		local formspecmails = modCorreio.get_formspecmails(playername)
		--print("formspecmails = "..formspecmails)
		local formspec = "size[8,7.5]"
		.."image[2.2,0.0;0.7,0.7;obj_mail.png]"
		.."label[2.75,0;CARTA DE CORREIO]"
		--.."textlist[0,0.7;7.7,6;selmail;"..formspecmails..";"..modCorreio.mailbox[playername].selmail..";false]"
		.."field[0.5,1.0;7.7,1.0;toplayer;Destinatario:;]"
		.."textarea[0.5,2.0;7.7,5.5;message;Mensagem:;]"
		--.."button[3.5,7;1.5,0.5;sendmail;ENVIAR]"
		.."button_exit[3.5,7;1.5,0.5;sendmail;ENVIAR]"
		
		minetest.show_formspec(playername,"modCorreio.mailmessage",formspec)
	end
end

minetest.register_on_player_receive_fields(function(sender, formname, fields)
	if formname == "modCorreio.mailmessage"  then
		local sendername = sender:get_player_name()
		--print()
		minetest.log('action',"[modCorreio] fields = "..dump(fields))
		if fields.sendmail then
			if fields.toplayer~=nil and type(fields.toplayer)=="string" and fields.toplayer~="" then
				if fields.message~=nil and type(fields.message)=="string" and fields.message~="" then
					local carta = modCorreio.set_mail(sendername, fields.toplayer, fields.message)
					if carta~=nil then
						local itemWielded = sender:get_wielded_item()
						if itemWielded:get_name()=="correio:papermail" and not minetest.setting_getbool("creative_mode") then
							itemWielded:take_item()
							sender:set_wielded_item(itemWielded)
						end
						--minetest.show_formspec(sendername,"","size[5,1]label[0,0;Sua mensagem foi enviada com sucesso!]") --Infelizmente nao existe metodo para fechar formspec.
						minetest.chat_send_player(sendername, "Sua mensagem foi enviada com sucesso!")
					else
						minetest.chat_send_player(sendername, "Houve uma falha inesperada ao enviar sua mensagem! (Entre em contato dom o desenvolvedor do mod 'modCorreio'.)")
					end
				else
					minetest.chat_send_player(sendername, "Favor digite uma mensagem antes de enviar sua carta!")
				end
			else
				minetest.chat_send_player(sendername, "Favor digite o nome exato da pessoa que recebera sua carta!")
			end
		end
	end
end)

minetest.register_craftitem("correio:papermail", {
	description = "Carta de Correio (Envia Carta)",
	inventory_image = "obj_mail.png",
	--stack_max=16, --Acumula 16 por slot
	--groups = { eat=1 },
	on_use = function(itemstack, user, pointed_thing)
		modCorreio.openpapermail(user:get_player_name())
	end,
})

if minetest.get_modpath("lunomobs") then
	minetest.register_craft({
		output = 'correio:papermail',
		recipe = {
			{"lunomobs:feather"},
			{"dye:violet"},
			{"default:paper"},
		}
	})
else
	minetest.register_craft({
		output = 'correio:papermail',
		recipe = {
			{"default:stick"}, --{"lunorecipes:feather"},
			{"dye:violet"},
			{"default:paper"},
		}
	})
end


minetest.register_alias("mail"				,"correio:papermail")
minetest.register_alias("papermail"			,"correio:papermail")
minetest.register_alias("carta"				,"correio:papermail")
minetest.register_alias("cartadecorreio"	,"correio:papermail")

