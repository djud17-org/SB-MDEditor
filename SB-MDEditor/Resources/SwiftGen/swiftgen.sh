#!/usr/bin/env sh

export PATH="$PATH:/opt/homebrew/bin"

OUTPUT_FILES=()

COUNTER=0

while [ $COUNTER -lt ${SCRIPT_OUTPUT_FILE_COUNT} ];
do
    tmp="SCRIPT_OUTPUT_FILE_$COUNTER"
    OUTPUT_FILES+=("${!tmp}")
    COUNTER=$[$COUNTER+1]
done

for file in "${OUTPUT_FILES[@]}"
do
    if [ -f "$file" ]
    then
        chmod a=rw "$file"
    fi
done

if which swiftgen > /dev/null; then
	swiftgen config run --config SB-MDEditor/Resources/SwiftGen/swiftgen.yml
else
	echo "warning: SwiftGen not installed, download from https://github.com/SwiftGen/SwiftGen"
	exit 1
fi

for file in "${OUTPUT_FILES[@]}"
do
    chmod a=r "$file"
done
