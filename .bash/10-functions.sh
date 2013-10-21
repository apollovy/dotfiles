#!/bin/bash

function activate {
	source ./venv/bin/activate
}

function gl {
	git log $@ --pretty="%d %s [%an: <%cd>] %h" --graph
}

function go {
	cd $PROJECTS_ROOT/$1
	a
	cd $SOURCE_DIR_NAME
}
