#!/bin/bash
# ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥
# ♥
# ♥					A script made in shell to manage version and backups of my Database PostgreSQL
# ♥
# ♥					@author ovictoraurelio
# ♥					@github http://github.com/ovictoraurelio
# ♥					@website http://victoraurelio.com
# ♥
# ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ 

function inputU {
    printf "\t${wht}$1: ${blu}" 
}
function p {
    printf "\n\t${wht}$1$2$3"
}
function doing {
    printf "\n\t${blu}$1$2$3${yel}"
}
function finished {
    printf "\n\n\t${gre}$1$2$3${yel}"
}
function warn {
    printf "\n\t${yel}$1$2$3"
}
function error {
    printf "\n\n\t${red}$1$2$3${wht}"
}
function settings {	
	wht=$(tput sgr0);red=$(tput setaf 1);gre=$(tput setaf 2);yel=$(tput setaf 3);blu=$(tput setaf 4);
	mkdir $HOME/apps
	DIR=$HOME/apps
}
function telegram {
	doing "Installing telegram"
	doing "Downloading telegram"
	wget -O $DIR/telegram.tar.xz https://telegram.org/dl/desktop/linux
	mkdir ~/apps/telegram	
	tar -xvf $DIR/telegram.tar.xz --strip 1 -C $DIR/telegram
	doing "Executing telegram"
	$DIR/telegram/Telegram
	finished "Telegram successfully installed\n"
}
function code {	
	doing "Installing vs code"
	doing "Downloading vs code"
	wget -O $DIR/code.tar.gz https://go.microsoft.com/fwlink/?LinkID=620884
	mkdir ~/apps/code	
	tar -vzxf $DIR/code.tar.gz --strip 1 -C $DIR/code
	doing "Executing vs code"
	$DIR/code/code
	finished "VS Code successfully installed\n"
}
function MAIN {	
	settings
	telegram
	code
}
MAIN
