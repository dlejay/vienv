
# Edit custom list of global environment variable
vienv(){
	ENV_FOLDER=${XDG_DATA_HOME:-~/Library/Application Support}/Environment
	if [ -n "$1" ]
	then
		# Read helper file
		less "$ENV_FOLDER"/README.txt
	else
		# Edit the variable table
		${VISUAL:-${EDITOR:-vi}} "$ENV_FOLDER"/environment.txt &&

		# Reload the plist
		launchctl unload ~/Library/LaunchAgents/environment.plist &&
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
