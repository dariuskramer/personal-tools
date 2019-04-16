#!/usr/bin/env sh

set -e


SCRIPT_PATH=$(dirname $(python -c "import os,sys; print(os.path.realpath(os.path.expanduser(sys.argv[1])))" "${0}"))
LAUNCH_AGENTS_PATH="${HOME}/Library/LaunchAgents"
PLIST_TEMPLATE="LoginScripts.plist.template"
PLIST_LOADED="LoginScripts.plist-LOADED"


cd ${SCRIPT_PATH}

for scriptname in $(find . -type f \( -name '*.sh' ! -iname 'install.sh' ! -iname 'LoginScripts*' \) | xargs -n1 basename); do
	loginscript="LoginScripts.${scriptname}.plist"

	# copy the plist template
	cp -f "${PLIST_TEMPLATE}" "${loginscript}"
	chmod +x "${loginscript}"

	# change script path
	sed -i '' "s:@@@SCRIPT-PATH@@@:${SCRIPT_PATH}/${scriptname}:g" "${loginscript}"
	sed -i '' "s:@@@SCRIPT-NAME@@@:${scriptname}:g" "${loginscript}"

	# create a symbolic link
	ln -fs "$(pwd)/${loginscript}" "${LAUNCH_AGENTS_PATH}/LoginScripts.${scriptname}.plist"

	# load the script
	launchctl load "${LAUNCH_AGENTS_PATH}/LoginScripts.${scriptname}.plist"
done
