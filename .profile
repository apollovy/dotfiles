if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

export HOMEBREW_GITHUB_API_TOKEN="e7169410759028767691610b7abfb263106be551"

function sort_by_year {
  if [ -z $1 ]
  then
    echo 'Directory name required'
    return 1
  fi

  find $1 -type f -name '*.m4a' | parallel '_file={}; python /Users/apollov/work/mutagen/src/year_to_sort_by_album.py "$_file"'
}

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export PATH="/usr/local/sbin:$PATH"
