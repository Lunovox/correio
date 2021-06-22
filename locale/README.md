# TRANSLATES

To generate file '**template.pot**', did use command:

````xgettext -n *.lua -L Lua --force-po --keyword=modCorreio.translate --from-code=UTF-8 -o ./locale/template.pot````

To translate '**template.pot**' to your language use app poedit.:

````sudo apt-get inatall poedit````

# Convert '.po' file to '.tr' file.

### COMMAND SAMPLE: TRANSLATE TO BRASILIAN PORTUGUESSE
````
$ cd ./locale/
$ lua po2tr.lua "correio" "pt_BR.po"
$ rm "pt_BR.tr" "correio.pt_BR.tr"
$ cat correio.pt_BR.tr | less
````

Source Code: https://gitlab.com/4w/xtend/-/blob/master/xtend_default/tools/convert_po_file_to_tr_file/convert_po_file_to_tr_file.lua

