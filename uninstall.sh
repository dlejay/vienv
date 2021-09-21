# Nice output
red=`tput setaf 1`
reset=`tput sgr0`
say(){
	if [ -z "$1" ]
	then
		echo ""
	else
	echo "${red}===> ${reset}$1"
	fi
}

# Unload environment.plist
if [ -e ~/Library/LaunchAgents/environment.plist ]
then
	launchctl unload ~/Library/LaunchAgents/environment.plist
	say "Unloaded environment.plist"
fi

# Clean files
ENV_FOLDER=${XDG_DATA_HOME:-~/Library/Application Support}/Environment

if [ -d "$ENV_FOLDER" ]
then
	rm -rf "$ENV_FOLDER"
	say "Removed $ENV_FOLDER"
fi

if [ -d ~/Library/LaunchAgents ]
then
	rm -f ~/Library/LaunchAgents/environment.plist
	say 'Removed ~/Library/LaunchAgents/environment.plist'
	rm -f ~/Library/LaunchAgents/environment.readme.txt
	say 'Removed ~/Library/LaunchAgents/environment.readme.txt'
fi

say ""
say "Last step: you can remove vienv() from your .zshrc"
say ""
