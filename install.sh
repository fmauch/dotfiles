#!/bin/bash

# I hate git submodules so I wrote this little script. It uses a wstool-like notation of
# different objects with url, local name and branch name (and more) which all are installed.


function show_help()
{
  echo "Usage:"
  echo "  $0 [-g {https|ssh}]"
  echo ""
  echo "The optional argument -g can be used to define whether git pulls should be done using the https protocol or ssh. Defaults to https."
}

# Default clone method for git (can be either https or ssh)
method=https

# A POSIX variable
OPTIND=1         # Reset in case getopts has been used previously in the shell.
while getopts "h?g:" opt; do
  case "$opt" in
    h|\?)
      show_help
      exit 0
      ;;
    g)  method=$OPTARG
      ;;
  esac
done

if [[ "$method" != "https" && "$method" != "ssh" ]]; then
  echo "ERROR: Illegal git protocoll specified!"
  show_help
fi

######################### Declare modules here #########################
declare -A module0=(
  [url]=""
  [local_name]="stow"
  [branch]=""
  [stow_default]=true
)
declare -A module1=(
  [url]="git@github.com:fmauch/vim_snippets.git"
  [local_name]="vim_snippets"
  [branch]="master"
  [stow_default]=false
)
declare -A module2=(
  [url]="git@github.com:fmauch/vim_snippets_ros.git"
  [local_name]="vim_snippets_ros"
  [branch]="master"
  [stow_default]=false
)
declare -A module3=(
  [url]="git@github.com:fmauch/dot_profile.git"
  [local_name]="dot_profile"
  [branch]="master"
  [stow_default]=true
)
declare -A module4=(
  [url]="git@github.com:fmauch/dot_tmux.git"
  [local_name]="dot_tmux"
  [branch]="master"
  [stow_default]=true
)
declare -A module5=(
  [url]="git@github.com:fmauch/dot_vim.git"
  [local_name]="dot_vim"
  [branch]="master"
  [stow_default]=true
)
declare -A module6=(
  [url]="git@github.com:ohmyzsh/oh-my-zsh.git"
  [local_name]="zsh/.oh-my-zsh"
  [branch]="master"
  [stow_default]=true
)
declare -A module7=(
  [url]=""
  [local_name]="dot_zsh"
  [branch]=""
  [stow_default]=true
)
declare -A module8=(
  [url]="git@github.com:fmauch/dot_git.git"
  [local_name]="dot_git"
  [branch]="master"
  [stow_default]=true
)
######################### End of module declaration #########################
declare -n module


# Download and install modules
for module in "${!module@}"; do
  # Clone if necessary
  if [[ ! -z ${module[url]} ]]; then
    if [[ $method = "https" ]]; then
      repo=$(sed -e "s/:/\//" -e 's/git\@/https\:\/\//g' <<< ${module[url]})
    else
      repo=${module[url]}
    fi

    echo "Cloning module ${module[local_name]}"
    git clone -b ${module[branch]} $repo ${module[local_name]}
  fi

  # Stow it
  if [[ ${module[stow_default]} == true ]]; then
    echo "Stowing module ${module[local_name]}"
    stow ${module[local_name]}
  else
    echo "Not stowing module ${module[local_name]}"
  fi
done
