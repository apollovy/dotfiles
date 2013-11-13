#!/bin/bash

function activate {
	source ./venv/bin/activate
}

function gl {
	git log $@ --pretty="%d %s [%an: <%cd>] %h" --graph
}

function _get_projects_prefix {
	PROJECTS_PREFIX=''
	echo $PROJECTS_PREFIX
}

function _get_projects_suffix {
	PROJECTS_SUFFIX=`whoami`
	echo $PROJECTS_SUFFIX
}

function _get_branch_name {
	if [ -z $1 ]
	then
		BRANCH_NAME=master
	else
		BRANCH_NAME=$1
	fi
	echo $BRANCH_NAME
}

function _get_site_name {
	if [ -z $1 ]
	then
		SITE_NAME=site
	else
		SITE_NAME=$1
	fi
	echo $SITE_NAME
}

function _get_project_name {
	echo $1
}

function _get_project_root {
	PROJECT_NAME=`_get_project_name $1`
	if [ -z $PROJECT_NAME ]
	then
		echo Usage: "$0 "'<PROJECT_NAME> [SITE_NAME=site] [BRANCH_NAME=master]'
		return 1
	fi
	SITE_NAME=`_get_site_name $2`
	BRANCH_NAME=`_get_branch_name $3`
	PROJECTS_PREFIX=`_get_projects_prefix`
	PROJECTS_SUFFIX=`_get_projects_suffix`
	PROJECT_ROOT="$PROJECTS_PREFIX/$PROJECTS_ROOT/$PROJECT_NAME/$SITE_NAME/$PROJECTS_SUFFIX/$BRANCH_NAME"
	echo $PROJECT_ROOT
}

function go {
	export PROJECT_NAME=`_get_project_name $1`
	if [ -z $PROJECT_NAME ]
	then
		echo Usage: "$0 "'<PROJECT_NAME> [SITE_NAME=site] [BRANCH_NAME=master]'
		return 1
	fi
	export SITE_NAME=`_get_site_name $2`
	export BRANCH_NAME=`_get_branch_name $3`
	export PROJECTS_PREFIX=`_get_projects_prefix`
	export PROJECTS_SUFFIX=`_get_projects_suffix`
	export PROJECT_ROOT="$PROJECTS_PREFIX/$PROJECTS_ROOT/$PROJECT_NAME/$SITE_NAME/$PROJECTS_SUFFIX/$BRANCH_NAME"
	export PROJECT_FULL_NAME="$PROJECT_NAME"_"$SITE_NAME"_"$PROJECTS_SUFFIX"_"$BRANCH_NAME"

	export DUMP_ROOT="$PROJECT_ROOT/dumps"
	export DUMP_LATEST_MYSQL="$DUMP_ROOT/latest.mysql.sql"
	export DUMP_LATEST_PGSQL="$DUMP_ROOT/latest.pgsql.sql"

	cd $PROJECT_ROOT
	activate
	cd $SOURCE_DIR_NAME
}

function work {
	if [ -z $1 ]
	then
		echo -n Enter project name:
		read PROJECT_NAME
	else
		PROJECT_NAME=$1
	fi
	export PROJECT_NAME=$PROJECT_NAME
	screen -S $PROJECT_NAME
}

function make_current_dump {
	if [ -z $PROJECT_ROOT ]
	then
		echo First use \`go\` command to go into a project.
		return 1
	fi
	date=`date '+%F_%T'`
	dump_dir="$DUMP_ROOT/$date"
	pgsql_filename=$dump_dir/pgsql.sql
	pgsql_custom_filename=$dump_dir/pgsql.pg_dump
	mysql_filename=$dump_dir/mysql.sql
	mkdir -p $dump_dir
	pg_dump -Fc $PROJECT_FULL_NAME > $pgsql_custom_filename
	mysqldump -p $PROJECT_FULL_NAME > $mysql_filename
	ln -f -s $pgsql_custom_filename $DUMP_LATEST_PGSQL
	ln -f -s $mysql_filename $DUMP_LATEST_MYSQL
}

function manage_project_server {
	sudo supervisorctl $1 $PROJECT_FULL_NAME
}

function restart_project {
	manage_project_server restart
}

function stop_project {
	manage_project_server stop
}

function echo_project_port {
	grep proxy_pass /etc/nginx/sites-enabled/$PROJECT_FULL_NAME | cut -d ':' -f 3 | sed s/';'//
}

function _restore_dump {
	if [ -z $1 ] || [ -z $2 ] || [ -z $3 ]
	then
		echo 'Usage: _restore_dump <db_name> <pg_filename> <mysql_filename>'
		return 1
	fi
	pg_restore -O -c -d $1 $2
	mysql -p $1 < $3
}


function restore_latest_dump {
	if [ -z $PROJECT_FULL_NAME ] || [ -z $DUMP_LATEST_PGSQL ] || [ -z $DUMP_LATEST_MYSQL ]
	then
		echo First use \`go\` command to go into a project.
		return 1
	fi
	_restore_dump $PROJECT_FULL_NAME $DUMP_LATEST_PGSQL $DUMP_LATEST_MYSQL
}
