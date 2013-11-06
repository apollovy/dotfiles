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

function _get_branch_name {
	if [ -z $BRANCH_NAME ]
	then
		if [ -z $1 ]
		then
			BRANCH_NAME=master
		else
			BRANCH_NAME=$1
		fi
	fi
	echo $BRANCH_NAME
}

function _get_site_name {
	if [ -z $SITE_NAME ]
	then
		if [ -z $1 ]
		then
			SITE_NAME=site
		else
			SITE_NAME=$1
		fi
	fi
	echo $SITE_NAME
}

function _get_project_name {
	if [ -z $PROJECT_NAME ]
	then
		PROJECT_NAME=$1
	fi
	echo $PROJECT_NAME
}

function go {
	PROJECT_NAME=`_get_project_name $1`
	if [ -z $PROJECT_NAME ]
	then
		echo Usage: "$0 "'<PROJECT_NAME> [SITE_NAME=site] [BRANCH_NAME=master]'
		return 1
	fi
	export PROJECT_NAME
	echo $PROJECT_NAME

	SITE_NAME=`_get_site_name $2`
	export SITE_NAME
	echo $SITE_NAME

	BRANCH_NAME=`_get_branch_name $3`
	export BRANCH_NAME
	echo $BRANCH_NAME

	PROJECTS_PREFIX=`_get_projects_prefix`
	echo $PROJECTS_PREFIX

	PROJECTS_SUFFIX=`_get_projects_suffix`
	echo $PROJECTS_SUFFIX

	cd $PROJECTS_PREFIX/$PROJECTS_ROOT/$PROJECT_NAME/$SITE_NAME/$PROJECTS_SUFFIX/$BRANCH_NAME
	pwd
	activate
	cd $SOURCE_DIR_NAME
}

function work {
	echo -n Enter project name:
	read PROJECT_NAME
	export PROJECT_NAME=$PROJECT_NAME
	screen -S $PROJECT_NAME
}
