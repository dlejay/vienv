
# Edit custom list of global environment variable
vienv(){
	ENV_FOLDER=${XDG_DATA_HOME:-~/Library/Application Support}/Environment
	if [ -n "$1" ]
	then
		# Read helper file
		man "$ENV_FOLDER"/vienv.help
	else
		# Edit the variable table
		${VISUAL:-${EDITOR:-vi}} "$ENV_FOLDER"/environment.txt &&

		# Reload the plist
		if launchctl list | grep -q my.startup
		then
			launchctl unload ~/Library/LaunchAgents/environment.plist
		fi
		launchctl load ~/Library/LaunchAgents/environment.plist

		# Say
		red=`tput setaf 1`
		reset=`tput sgr0`
		say(){
			echo "${red}===>${reset} $@"
		}
		say 'Reloaded ~/Library/LaunchAgents/environment.plist'
		say "To see the changes," \
		"resart your terminal and all other apps"
	fi
}
