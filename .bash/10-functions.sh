#!/bin/bash

function activate {
	source ./venv/bin/activate
}

function gl {
	git log $@ --pretty="%d %s [%an: <%cd>] %h" --graph
}

function go {
	cd $PROJECTS_ROOT/$1/`whoami`
	activate
	cd $SOURCE_DIR_NAME
}

function screen {
	echo -n Enter project name:
	read PROJECT_NAME
	export PROJECT_NAME=$PROJECT_NAME
	env screen -S $PROJECT_NAME
}
