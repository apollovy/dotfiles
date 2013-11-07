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
	cd $PROJECT_ROOT
	activate
	cd $SOURCE_DIR_NAME
}

function work {
	echo -n Enter project name:
	read PROJECT_NAME
	export PROJECT_NAME=$PROJECT_NAME
	screen -S $PROJECT_NAME
}

function make_current_dump {
	if [ -z $PROJECT_ROOT ]
	then
		echo First use \`go\` command to go into a project.
		return 1
	fi
	dump_root="$PROJECT_ROOT/dumps"
	date=`date '+%F_%T'`
	dump_dir="$dump_root/$date"
	db_filename="$PROJECT_NAME"_"$SITE_NAME"_`whoami`_"$BRANCH_NAME"
	pgsql_filename=$dump_dir/pgsql.sql
	pgsql_custom_filename=$dump_dir/pgsql.pg_dump
	mysql_filename=$dump_dir/mysql.sql
	echo $db_filename $dump_root $date $dump_dir $pgsql_filename $pgsql_custom_filename $mysql_filename
	mkdir -p $dump_dir
	pg_dump -O -Fp -c $db_filename > $pgsql_filename
	pg_dump -Fc $db_filename > $pgsql_custom_filename
	mysqldump -p $db_filename > $mysql_filename
	ln -f -s $pgsql_filename $dump_root/latest.pgsql.sql
	ln -f -s $pgsql_custom_filename $dump_root/latest.pgsql.pg_dump
	ln -f -s $mysql_filename $dump_root/latest.mysql.sql
}
