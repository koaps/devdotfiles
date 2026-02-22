# debug terminal startup
#set -x

# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# Load the shell dotfiles, and then some:
for file in ~/.{exports,aliases,extra,completions,paths}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
  shopt -s "$option" 2> /dev/null
done

# Fix autoexpanding escapes
if ((BASH_VERSINFO >= 4))
    then shopt -s direxpand
fi

# source cargo env if it exists
if [ -d "$HOME/.cargo" ] ; then
    . "$HOME/.cargo/env"
fi

if [ -d "$HOME/.pyenv" ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init - bash)"
  eval "$(pyenv virtualenv-init -)"
fi
