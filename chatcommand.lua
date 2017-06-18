minetest.register_chatcommand("broadcast", {
	privs = {postman=true},
	params = "<mensagem>",
	description = "/broadcast <mensagem> : Envia email para todos os players cadastrados.",
	func = function(name, param)
		modCorreio.chat_broadcast(name, param)
	end,
})

minetest.register_chatcommand("publicar", {
	privs = {postman=true},
	params = "<mensagem>",
	description = "/publicar <mensagem> : Envia email para todos os players cadastrados.",
	func = function(name, param)
		modCorreio.chat_broadcast(name, param)
	end,
})

minetest.register_chatcommand("delolds", {
	privs = {postman=true},
	params = "",
	description = "/delolds : Apaga os email com mais de trinta dias em todo o servidor.",
	func = function(playername, param)
		modCorreio.chat_delolds(playername)
	end,
})

minetest.register_chatcommand("mail", {
	privs = {postman=true},
	params = "<playername> <mensagem>",
	description = "/mail <playername> <mensagem> : Envia email para um player.",
	func = function(playername, param)
		if type(modCorreio.openpapermail)=="function" then
			modCorreio.openpapermail(playername)
		else
			modCorreio.chat_writemail(playername, param)
		end
	end,
})

minetest.register_chatcommand("escrever", {
	privs = {postman=true},
	params = "<playername> <mensagem>",
	description = "/escrever <playername> <mensagem> : Envia email para um player.",
	func = function(playername, param)
		if type(modCorreio.openpapermail)=="function" then
			modCorreio.openpapermail(playername)
		else
			modCorreio.chat_writemail(playername, param)
		end
	end,
})


minetest.register_chatcommand("read", {
	privs = {postman=true},
	--params = "",
	description = "/read : Exite todos sos seus email.",
	func = function(playername, param)
		if type(modCorreio.openinbox)=="function" then
			modCorreio.openinbox(playername)
		else
			modCorreio.chat_readmail(playername)
		end
	end,
})

minetest.register_chatcommand("inbox", {
	privs = {postman=true},
	--params = "",
	description = "/inbox : Exite todos sos seus email.",
	func = function(playername, param)
		if type(modCorreio.openinbox)=="function" then
			modCorreio.openinbox(playername)
		else
			modCorreio.chat_readmail(playername)
		end
	end,
})

minetest.register_chatcommand("ler", {
	privs = {postman=true},
	--params = "",
	description = "/ler : Exite todos sos seus email.",
	func = function(playername, param)
		if type(modCorreio.openinbox)=="function" then
			modCorreio.openinbox(playername)
		else
			modCorreio.chat_readmail(playername)
		end
	end,
})

minetest.register_chatcommand("clearmails", {
	privs = {postman=true},
	--params = "",
	description = "/clearmails : apaga todos os email ja lido do player.",
	func = function(name, param)
		modCorreio.chat_delreadeds(name)
	end,
})

minetest.register_chatcommand("limpar", {
	privs = {postman=true},
	--params = "",
	description = "/limpar : apaga todos os email ja lido do player.",
	func = function(name, param)
		modCorreio.chat_delreadeds(name)
	end,
})

minetest.register_chatcommand("correio", {
	params = "",
	description = "Exibe todos os comando deste mod",
	privs = {},
	func = function(name, param)
		minetest.chat_send_player(name, "    ", false)
		minetest.chat_send_player(name, "############################################################################################", false)
		minetest.chat_send_player(name, "### CORREIO                                                                              ###", false)
		minetest.chat_send_player(name, "### Desenvolvedor:'Lunovox Heavenfinder'<rui.gravata@gmail.com>                          ###", false)
		minetest.chat_send_player(name, "### Languages: English (Default), Portuguese                                             ###", false)
		minetest.chat_send_player(name, "### Download: https://github.com/Lunovox/correio                                         ###", false)
		minetest.chat_send_player(name, "### License GNU AGPL ( https://pt.wikipedia.org/wiki/GNU_Affero_General_Public_License ) ###", false)
		minetest.chat_send_player(name, "############################################################################################", false)
		minetest.chat_send_player(name, "CRAFTS ADICIONADOS:", false)
		minetest.chat_send_player(name, "   * Caixa de correio (Papel[B2]+Tabua[A1A2A3B1B3C1C2C3])", false)
		minetest.chat_send_player(name, "       (Permite ler as suas mensagens recebidas)", false)
		minetest.chat_send_player(name, "   * Carta de correio (Pena[A1]+Tinta Roxa[A2]+Papel[A3])", false)
		minetest.chat_send_player(name, "       (Permite mensagens para algum player especifico)", false)
		minetest.chat_send_player(name, "", false)
		minetest.chat_send_player(name, "COMANDOS ADMINISTIVOS:", false)
		minetest.chat_send_player(name, "   * /broadcast <Message>", false)
		minetest.chat_send_player(name, "   * /publicar <Mensagem>", false)
		minetest.chat_send_player(name, "       (Envia carta para todos os players ja cadastrado)", false)
		minetest.chat_send_player(name, "   * /delolds", false)
		minetest.chat_send_player(name, "       (Apaga cartas com mais de 30 dias de todos os players.)", false)
		minetest.chat_send_player(name, "   * /mail [<PlayerName> <Message>]", false)
		minetest.chat_send_player(name, "   * /escrever [<NomeDoJogador> <Mensagem>]", false)
		minetest.chat_send_player(name, "       (Envia uma carta para caixa de correio de um jogador)", false)
		minetest.chat_send_player(name, "   * /inbox", false)
		minetest.chat_send_player(name, "   * /read", false)
		minetest.chat_send_player(name, "   * /ler", false)
		minetest.chat_send_player(name, "       (Mostra todas as cartas que estao em sua caixa de correio)", false)
		minetest.chat_send_player(name, "   * /clearmails", false)
		minetest.chat_send_player(name, "   * /limpar", false)
		minetest.chat_send_player(name, "       (Apaga todos os email lidos anteriormente)", false)
		minetest.chat_send_player(name, "############################################################################################", false)
		minetest.chat_send_player(name, name..", precione F10 e use a rolagem do mouse para ler todo este tutorial!!!", false)
	end,
})
