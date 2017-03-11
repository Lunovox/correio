modCorreio = {
	--default_url = minetest.get_worldpath().."/correio.tbl",
	huds = { },
	hud_time = 0,
	hud_delay = 5, -- Delay in seconds of notice of arrival of the new message. Need to be longer than 5 seconds to not cause lag on server
	max_days_validate = 30, -- 30 dias de validade de cada carta. Evita que jogadores q abandonaram o servidor tenham cartas!
}
