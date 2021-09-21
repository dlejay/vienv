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

# Download
cd $TMPDIR
curl -sLO https://raw.githubusercontent.com/dlejay/vienv/trunk/environment.plist
curl -sLO https://raw.githubusercontent.com/dlejay/vienv/trunk/environment.txt
curl -sLO https://raw.githubusercontent.com/dlejay/vienv/trunk/environment.readme.txt
curl -sLO https://raw.githubusercontent.com/dlejay/vienv/trunk/vienv.sh
curl -sLO https://raw.githubusercontent.com/dlejay/vienv/trunk/vienv.help

# Install
if [ ! -d ~/Library/LaunchAgents ]
then
	mkdir -p ~/Library/LaunchAgents
	say "Created folder ~/Library/LaunchAgents"
fi

cp environment.plist ~/Library/LaunchAgents
say 'Installed environment.plist to ~/Library/LaunchAgents'

cp environment.readme.txt ~/Library/LaunchAgents
say 'Installed environment.readme.txt to ~/Library/LaunchAgents'

ENV_FOLDER=${XDG_DATA_HOME:-~/Library/Application Support}/Environment
mkdir -p "$ENV_FOLDER"
say "Created folder $ENV_FOLDER"

cp vienv.help "$ENV_FOLDER"
say "Installed vienv.help"

cp environment.txt "$ENV_FOLDER"
say "Installed environment.txt"

# Add vienv() if not already present in .zshrc
ZSHRC=${ZDOTDIR:-$HOME}/.zshrc
! grep -sq ^vienv\(\) $ZSHRC && cat vienv.sh >> $ZSHRC

say "The function vienv() was added to your .zshrc."
say ""
say "The file environment.txt already contains some default variables."
say "Use vienv to edit it now!"
say ""

# Clean
rm environment.txt
rm environment.readme.txt
rm environment.plist
rm vienv.sh
rm vienv.help
