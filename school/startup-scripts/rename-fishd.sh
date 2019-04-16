#!/usr/bin/env sh

FISH_PATH="${HOME}/.config/fish"
MACADDR="$(ifconfig en0 | grep ether | tr -d '\t' | cut -d ' ' -f 2 | tr -d ':')"

NEW_FISHD="fishd.${MACADDR}"
OLD_FISHD="$(cd "${FISH_PATH}" && ls -1 fishd.* | grep -E '^fishd\.[0-9a-f]+$')"

#echo NEW_FISHD ${NEW_FISHD}
#echo OLD_FISHD ${OLD_FISHD}
cd "${FISH_PATH}" && mv -vf "${OLD_FISHD}" "${NEW_FISHD}"
