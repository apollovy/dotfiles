if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

export HOMEBREW_GITHUB_API_TOKEN="a5bb1698b0ff9cb2a68a993c32ea8779758e70ae"

function sort_by_year {
  if [ -z $1 ]
  then
    echo 'Directory name required'
    return 1
  fi

  find $1 -type f -name '*.m4a' | parallel '_file={}; python /Users/apollov/work/mutagen/src/year_to_sort_by_album.py "$_file"'
}
