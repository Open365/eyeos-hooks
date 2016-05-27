#!/bin/sh

# See how many times 'node_modules' apear in path, if more than one, it is a module of a module and we don't do anyhting
nodeModulesTimesInPath=$(echo $PWD | sed 's/node_modules/node_modules\n/g' | grep -c 'node_modules')
if [ $nodeModulesTimesInPath -gt 1 ];then
    echo "Inception module"
    exit 0
fi

GIT_ROOT=$(git rev-parse --show-toplevel)
GIT_USERNAME=$(git config user.name)

if [ $? -ne 0 ]; then
	echo "Not doing anything since this is not a git repo"
	exit 0;
fi

if [ "$(basename "$GIT_ROOT")" = "eyeos-hooks" ]
then
    exit 0
fi

if [ "$GIT_USERNAME" = "Jenkins" ]
then
	echo "Not running eyeos hooks because this is a jenkins's commit"
	exit 0
fi

PRE_COMMIT_FILE=".git/hooks/pre-commit"


# Deleting previous eyeos hooks
touch "$GIT_ROOT/$PRE_COMMIT_FILE"
chmod a+x "$GIT_ROOT/$PRE_COMMIT_FILE"
sed -i '/####EYEOS-HOOKS-BEGIN####/,/####EYEOS-HOOKS-END####/d' "$GIT_ROOT/$PRE_COMMIT_FILE"

# Adding current hooks to repo
echo -e "\n####EYEOS-HOOKS-BEGIN####" >> "$GIT_ROOT/$PRE_COMMIT_FILE"
cat ./hooks/pre-commit >> "$GIT_ROOT/$PRE_COMMIT_FILE"
echo -e "\n####EYEOS-HOOKS-END####" >> "$GIT_ROOT/$PRE_COMMIT_FILE"
