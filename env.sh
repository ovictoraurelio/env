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
	if [ ! -d $HOME/apps ]; then 
		doing "Creating apps folder"
		mkdir $HOME/apps
	fi
	DIR=$HOME/apps
}
function backgroundImage {
    wget -O $DIR/background.jpg http://cin.ufpe.br/~vags/tardis_wallpaper.jpg
    gsettings set org.gnome.desktop.background picture-uri file://$DIR/background.jpg
}
function addShortcut {
    doing "installing telegram"
    echo "$HOME/.local/share/applications/$1"

    gtk-update-icon-cache -f $HOME/.local/share/icons/hicolor >/dev/null 2>&1
	desktop-file-install --dir=$HOME/.local/share/applications "$HOME/.local/share/applications/$1"
    
    favorites=$(
python << EOF
from collections import OrderedDict
array = eval("$(gsettings get com.canonical.Unity.Launcher favorites)")
print(str(list(OrderedDict.fromkeys(array[:-3] + ["$1"] + array[-3:]))))
EOF
)    
	gsettings set com.canonical.Unity.Launcher favorites "$favorites"
    
    finished "wow"
    echo "$favorites"
}

function telegram {
	doing "Installing telegram"
	doing "Downloading telegram"
	wget -O $DIR/telegram.tar.xz https://telegram.org/dl/desktop/linux
	mkdir ~/apps/telegram	
	tar -xvf $DIR/telegram.tar.xz --strip 1 -C $DIR/telegram
	doing "Executing telegram"
	$DIR/telegram/Telegram &
    configTelegram
	finished "Telegram successfully installed\n"   
}

function code {	
	doing "Installing vs code"
	doing "Downloading vs code"
	wget -O $DIR/code.tar.gz https://go.microsoft.com/fwlink/?LinkID=620884
	mkdir ~/apps/code	
	tar -vzxf $DIR/code.tar.gz --strip 1 -C $DIR/code
	doing "Adding settings"
	configCode
	doing "Executing vs code"	
	$DIR/code/code &
	finished "VS Code successfully installed\n"
}

function configTelegram {
    cat << EOF > $HOME/.local/share/applications/telegram.desktop
[Desktop Entry]
Version=1.0
Name=Telegram Desktop
Comment=Official desktop version of Telegram messaging app
TryExec=$DIR/telegram/Telegram
Exec=$DIR/telegram/Telegram -- %u
Icon=telegram
Terminal=false
StartupWMClass=TelegramDesktop
Type=Application
Categories=Network;InstantMessaging;Qt;
MimeType=x-scheme-handler/tg;
X-Desktop-File-Install-Version=0.22
EOF    
    addShortcut telegram.desktop
}


function configCode {
	cat << EOF > $HOME/.config/Code/User/settings.json	
{
    "files.autoSave": "off",
    "workbench.colorTheme": "Northem Dark",
    "workbench.iconTheme": "material-icon-theme",
    "sync.gist": "47639fa50f09b6dc7d21d33dc7922860",
    "sync.lastUpload": "2017-01-09T00:50:26.952Z",
    "sync.autoDownload": true,
    "sync.autoUpload": false,
    "sync.lastDownload": "2017-01-09T00:40:19.423Z",
    "sync.forceDownload": false,
    "sync.anonymousGist": false,
    "sync.host": "",
    "sync.pathPrefix": "",
    "sync.quietSync": false,
    "sync.askGistName": false,                      
    "workbench.activityBar.visible": true,
    "files.associations": {
        "*.twig": "html",
        "*.html": "twig"
    },
    "extensions.ignoreRecommendations": false,
    "window.zoomLevel": 0
}
EOF
	cat << EOF > $HOME/.config/Code/User/keybindings.json	
[
    { "key": "ctrl+\\\",              "command": "workbench.action.toggleSidebarVisibility" },
    { "key": "ctrl+k ctrl+up",        "command": "workbench.action.splitEditor" },
    { "key": "ctrl+t",                "command": "workbench.action.quickOpen" },
    { "key": "ctrl+e",                "command": "workbench.action.showAllSymbols" },
    { "key": "ctrl+j", 				  "command": "workbench.action.terminal.toggleTerminal" }
]
EOF

    cat << EOF > $HOME/.local/share/applications/code.desktop

[Desktop Entry]
Version=1.0
Name=code
Comment=Text Editor VS Code
TryExec=$DIR/code/code
Exec=$DIR/code/code 
Icon=code
Terminal=false
StartupWMClass=VSCode
Type=Application
Categories=Development;IDE;
MimeType=x-scheme-handler/tg;
X-Desktop-File-Install-Version=0.22
EOF
    
    addShortcut code.desktop
}

function MAIN {	
	settings
    backgroundImage
	telegram
    code
}
MAIN
