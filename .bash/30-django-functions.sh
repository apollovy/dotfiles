#!/bin/bash

function get_app_names {
	ls apps | grep -v __
}

function manage {
	python manage.py $@
}

function runserver {
	manage runserver $@
}

function is_localized_app {
	if [ `ls apps/$1 | grep locale` ]; then
		echo 1
	else
		echo 0
	fi
}

function make_messages {
	python ../../manage.py makemessages --all
}

function make_all_messages {
	for APP in `get_app_names` ; do
		if [ `is_localized_app $APP` == 1 ]; then
			echo Making messages in $APP:
			cd apps/$APP
			make_messages
			cd ../../
		fi
	done
}

function compile_messages {
	python ../../manage.py compilemessages
}

function compile_all_messages {
	for APP in `get_app_names` ; do
		if [ `is_localized_app $APP` == 1 ]; then
			echo Compiling messages in $APP:
			cd apps/$APP
			compile_messages
			cd ../../
		fi
        done
}

function schema_migration {
	for APP in `get_app_names` ; do
		if [ `ls apps/$APP | grep migrations` ]; then
			echo Migrating schema in $APP:
			manage schemamigration $APP --auto $@
		fi
	done
}

function migrate {
	manage migrate $@
}
