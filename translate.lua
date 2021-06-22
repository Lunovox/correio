local ngettext

if minetest.get_modpath("intllib") then
	if intllib.make_gettext_pair then
		-- New method using gettext.
		modCorreio.translate, ngettext = intllib.make_gettext_pair()
	else
		-- Old method using text files.
		modCorreio.translate = intllib.Getter()
	end
	--minetest.log("warning", "[PORTABLEBOXES] Tradutor 'intllib'!")
elseif minetest.get_translator ~= nil and minetest.get_translator(minetest.get_current_modname()) then
	modCorreio.translate = minetest.get_translator(minetest.get_current_modname())
	--minetest.log("warning", "[PORTABLEBOXES] Tradutor padrão!")
else
	modCorreio.translate = function(txt) return txt end
	--minetest.log("warning", "[PORTABLEBOXES] Sem Tradutor!")
end
