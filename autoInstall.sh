if [[ $1 = "r" ]]
then
	./install/installer_packages.sh
fi
python3 snakePit/linker.py config/ ~/.config $1
python3 snakePit/linker.py surface/ ~ $1
if [[ $1 = "r" ]]
then
	./install/installer_git.sh
	vim -c 'PluginInstall' -c 'qa'
	./install/installer_vimPluggins.sh
fi
