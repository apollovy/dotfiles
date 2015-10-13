function go {
  export PROJECT_NAME=`_get_project_name $1`
  if [ -z $PROJECT_NAME ]
  then
    echo Usage: "$0 "'<PROJECT_NAME> [SITE_NAME=site] [BRANCH_NAME=master]'
    return 1
  fi
  export SITE_NAME=`_get_site_name $2`
  export PROJECTS_PREFIX=`_get_projects_prefix`
  export PROJECT_ROOT="$PROJECTS_PREFIX/$PROJECTS_ROOT/$PROJECT_NAME/$SITE_NAME/$PROJECTS_SUFFIX/$BRANCH_NAME"
  export PROJECT_FULL_NAME="$PROJECT_NAME"_"$SITE_NAME"_"$PROJECTS_SUFFIX"_"$BRANCH_NAME"

  export DUMP_ROOT="$PROJECT_ROOT/dumps"
  export DUMP_LATEST_MYSQL="$DUMP_ROOT/latest.mysql.sql"
  export DUMP_LATEST_PGSQL="$DUMP_ROOT/latest.pgsql.sql"

  # cd $PROJECT_ROOT
  # activate
  cd $PROJECT_ROOT/$SOURCE_DIR_NAME
  workon $PROJECT_NAME

  # syntastic
  export PYTHONPATH=$PYTHONPATH:"$VIRTUAL_ENV/lib/python2.7/site-packages"
}
function beep {
  afplay "/Users/apollov/Music/iTunes/iTunes Media/Music/Game OST/Sonic the Hedgehog 2/16 Dr. Robotnik's Theme.m4a"
}

_nwn_root_dir='/Users/apollov/Applications/Wineskin/NWN.app'
_nwn_contents_dir=$_nwn_root_dir/Contents

function nwn {
  cp $_nwn_contents_dir/nwn.plist $_nwn_contents_dir/Info.plist
  open $_nwn_root_dir
}

function leto {
  cp $_nwn_contents_dir/leto.plist $_nwn_contents_dir/Info.plist
  open $_nwn_root_dir
}
