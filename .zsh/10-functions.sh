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
		echo -n 'Enter client name: '
		read PROJECT_NAME
		echo -n 'Enter site name: '
		read SITE_NAME
	else
		PROJECT_NAME=$1
		if [ -z $2 ]; then
			SITE_NAME=site
		else
			SITE_NAME=$2
		fi
	fi
	export PROJECT_NAME
	export SITE_NAME
	screen -c ~/.screen/work.conf -S "${PROJECT_NAME}.${SITE_NAME}"
}

function make_current_dump {
	if [ -z $PROJECT_ROOT ]
	then
		echo First use \`go\` command to go into a project.
		return 1
	fi
	date=`date '+%F_%T'`
	dump_dir="$DUMP_ROOT/$date"
	pgsql_custom_filename=pgsql.pg_dump
	pgsql_custom_filename_absolute=$dump_dir/$pgsql_custom_filename
	mysql_filename=mysql.sql
	mysql_filename_absolute=$dump_dir/$mysql_filename
	mkdir -p $dump_dir
	pg_dump -Fc $PROJECT_FULL_NAME > $pgsql_custom_filename_absolute
	mysqldump -p $PROJECT_FULL_NAME > $mysql_filename_absolute
	ln -f -s $date/$pgsql_custom_filename $DUMP_LATEST_PGSQL
	ln -f -s $date/$mysql_filename $DUMP_LATEST_MYSQL
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

function __rsync_dir {
	source_dir=$1
	target_dir=$2
	shift 2
	rsync_keys=$@

	rsync -avz -e ssh $rsync_keys "$client_name"."$project_name"."$realm_name":"$source_dir" `_get_project_root $client_name $project_name $branch_name`/$target_dir
}

function _sync_with_installation {
	if [ -z $1 ] || [ -z $2 ] || [ -z $3 ] || [ -z $4 ] || [ -z $5 ]
	then
		echo 'Usage: $FUNCNAME <client_name> <project_name> <realm_name> <user_name> <branch_name>'
		return 1
	fi
	
	export client_name=$1
	export project_name=$2
	export realm_name=$3
	export user_name=$4
	export branch_name=$5

	conf_file=$HOME/.rsync/$client_name/$project_name/$realm_name.conf
	while read line
	do
		__rsync_dir $line
	done < $conf_file

}

function sync {
	if [ -z $PROJECT_FULL_NAME ]
	then
		echo First use \`go\` command to go into a project.
		return 1
	fi
	_sync_with_installation $PROJECT_NAME $SITE_NAME production `whoami` $BRANCH_NAME
}

function mp32aac {
	export _src=~/Music/src _target=~/Music/convert
	find ${_src} -type d -mindepth 1 | parallel '_dir={}; mkdir ${_target}/${_dir##${_src}/}'
	find ${_src} -type f \( -name '*.mp3' -o -name '*.m4a' -o -name '*.flac' \) | parallel '_file={}; _target_file=${_target}/${${_file%.*}##${_src}/}.m4a; ffmpeg -i "$_file" -c:a libfdk_aac -b:a 128K -y -nostdin -vn $_target_file; aacgain -r -c $_target_file'
}
function vk_video_dl {
	headers="User-Agent: Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10A5376e"
	url=${1%/*}
	filename=${1##*/}

	for ts_file in `curl -H "$headers" "${url}/${filename}.mp4.m3u8" 2> /dev/null | grep -v '#'`; do
		curl -H "$headers" "${url}/${ts_file%}" >> ${filename}.ts
	done
}
