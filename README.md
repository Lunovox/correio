# CORREIO
Adds mailbox and mail paper that allow ordinary players to send messages to each other even if the recipient is not online. The player who receives a message will be warned with a letter symbol on his screen.

**Dependencies:**
  * default (Minetest Game Included)
  * dye (Minetest Game Included)
  * [lib_savevars](https://github.com/Lunovox/lib_savevars) → Library of writing of variables

**Optional Dependencies:**
  * [intllib](https://github.com/minetest-mods/intllib) → Facilitates the translation of several other mods into your native language, or other languages.
  * brazutec?
  * lunomobs?
  
**Licence:**
 * GNU AGPL: https://pt.wikipedia.org/wiki/GNU_Affero_General_Public_License

**Developers:**
 * [Lunovox](mailto:lunovox@openmailbox.org)

**Settings:**
  * Change the file **'config.lua'** to change the initial settings of the mod, such as:
  	* ````hud_delay = 5```` →  Delay in seconds of notice of arrival of the new message. Need to be longer than 5 seconds to not cause lag on server
	* ````max_days_validate = 30```` → Limit how long a mail can be stored inside the mailbox. This prevents emails from players that did abandon the server.

**Commands:**
 * ````/broadcast <mensagem>```` or ````/publicar <mensagem>```` → Send email to all registered players. You need priv 'postman'.
 * ````/delolds```` → Delete emails that are more than 30 days old on the whole server. Serves to relieve server memory. You need priv 'postman'.
 * ````/mail [<ToPlayer> <Message>]```` or ````/escrever [<Destinatario> <mensagem>]```` → If you do not enter parameters you will open a panel to fill the recipient and the message you want to send. You need priv 'postman'.
 * ````/read```` or ````/inbox```` or ````/ler```` → Displays incoming messages. You need priv 'postman'.
 * ````/clearmails```` or ````/limpar```` → Delete all emails already read by the player. You need priv 'postman'.
 * ````/correio```` → Displays the above mentioned commands.
 		
**Screenshot of Mod:**
![](https://raw.githubusercontent.com/Lunovox/correio/master/screenshot.png)