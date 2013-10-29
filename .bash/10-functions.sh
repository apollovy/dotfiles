#!/bin/bash

function activate {
	source ./venv/bin/activate
}

function gl {
	git log $@ --pretty="%d %s [%an: <%cd>] %h" --graph
}

function _get_projects_prefix {
	echo ''
}

function _get_projects_suffix {
	echo `whoami`
}

function go {
	if [ -z $PROJECT_NAME ]
	then
		PROJECT_NAME=$1
	fi
	cd `_get_projects_prefix`/$PROJECTS_ROOT/$PROJECT_NAME/`_get_projects_suffix`
	activate
	cd $SOURCE_DIR_NAME
}

function screen {
	echo -n Enter project name:
	read PROJECT_NAME
	export PROJECT_NAME=$PROJECT_NAME
	env screen -S $PROJECT_NAME
}
