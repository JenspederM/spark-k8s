function _color() {
  green='\033[1;32m'
  red='\033[1;31m'
  yellow='\033[1;33m'
  blue='\033[0;34m'
  purple='\033[0;35m'
  cyan='\033[0;36m'
  white='\033[0;37m'
  reset='\033[0m'
  bold='\033[1m'
  case $1 in
    "green")
      echo "${green}$2${reset}"
    ;;
    "red")
      echo "${red} $2 ${reset}"
    ;;
    "yellow")
      echo "${yellow} $2 ${reset}"
    ;;
    "blue")
      echo "${blue} $2 ${reset}"
    ;;
    "purple")
      echo "${purple} $2 ${reset}"
    ;;
    "cyan")
      echo "${cyan} $2 ${reset}"
    ;;
    "white")
      echo "${white} $2 ${reset}"
    ;;
    "default")
      echo "${reset} $2 ${reset}"
  esac
}


function logger() {
  usage="log <level> <message>"
  current_time=$(gdate +'%Y-%m-%dT%T.%3N%z')
  if [[ $# -eq 0 || $# -eq 1 || $# -gt 2 ]]; then
    echo $usage
    return
  fi
  
  level=$1
  
  case $level in
    debug)
      message=$(_color "cyan" "$current_time - $level - $2")
    ;;
    info)
      message=$(_color "white" "$current_time - $level  - $2")
    ;;
    warn)
      message=$(_color "yellow" "$current_time - $level  - $2")
    ;;
    error)
      message=$(_color "red" "$current_time - $level - $2")
    ;;
    *)
      echo $usage
    ;;
  esac
  
  echo -e "$message"
}

function unpack_and_remove_tar_files() {
  for FILE in `find . -name "$1"`
  do
    if [[ $FILE == *.tgz ]]; then
      logger debug "Unpacking $FILE"
      tar -xf $FILE
      logger debug "Removing $FILE"
      rm -rf $FILE
    fi
  done
}