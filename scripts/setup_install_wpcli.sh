#!/bin/bash 



# PRINT HELP INFORMATION
# -----------------------------------------------
usage() {
    echo "Wordpress CLI Install Script"
    echo "wp-cli.org"    
    echo ""
    echo "install_wpcli.sh [options]"
    echo -e "\nOPTIONS"
    echo -e "\t-h --help" 
    echo -e "\t--install-user    \t user install in /home/bin *Default"
    echo -e "\t--install-system  \t system install in /usr/local/bin"
    echo -e "\t--install-project \t project install in current directory ./bin"
    echo -e "\t--install-completion \t install wpcli tab completion"
    echo ""
}


# INSTALL WP CLI 
# -----------------------------------------------
install_wpcli() {
  TMP=./wp_tmp
  DIR=${1:-$HOME/bin}
  MODE=${2:-user}
  URL=${3:-https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar}

  echo "Install Mode: $MODE"  

  if [ ! -d $DIR ]; then
      echo "Creating directory $DIR"
      mkdir $DIR

  elif [ -f $DIR/wp ] || [ -f $DIR/wp-cli.phar ]; then  
      echo "Wordpress cli already exists at $DIR"
      return;

  else
      mkdir $TMP
      cd $TMP
      curl -O $URL
      cd ..
      chmod +x $TMP/wp-cli.phar


      echo "Tesing wpcli commands"
      php wp-cli.phar --info
      echo "Installing at $DIR" 
      if [ $MODE == "system" ]; then 
          sudo $TMP/chmod root:root wp-cli.phar 
          sudo mv $TMP/wp-cli.phar $DIR/wp
      else 
          mv $TMP/wp-cli.phar $DIR/wp
      fi 
      rm -rf $TMP
  fi
}



# INSTALL BASH COMPLETION 
# -----------------------------------------------
install_wpcli_completion() {
  DIR=${1:-$HOME/.wp-cli}
  MODE=${2:-user}
  URL=${3:-https://raw.githubusercontent.com/wp-cli/wp-cli/v1.5.1/utils/wp-completion.bash}
  TMP=./wp_comp

  echo "Installing wp bash completion at $COMP_DIR"

  if [ -f $DIR/wp-completion.bash ] && [ -f $DIR/wp ]; then
      echo "Completion already exists at /etc/bash_completion.d/wp"
      return;
  else
      echo "getting wp completion $COMP_URL" 
      mkdir $TMP
      cd $TMP       
      curl -O $URL
      cd .. 

      if [ $MODE == "system" ]; then 
          sudo chown root:root $TMP/wp-completion.bash 
          sudo mv $TMP/wp-completion.bash $DIR/
      else
          mv $TMP/wp-completion.bash $DIR/           
      fi

      . $DIR/wp-completion.bash

      rm -rf $TMP
      echo -e "wp-cli bash completion loaded temporarily, add"
      echo -e "\t$DIR/wp-completion.bash"
      echo -e "to your user .bashrc file to load this for every session"
  fi
}



# HANDLE INPUT ARGUMENTS 
# -----------------------------------------------
while [ "$1" != "" ]; do
  MODE="${1#--install-}"
  
  case $MODE in
    -h | --help) 
      usage 
      exit 
    ;;
    user) 
      USER_MODE=1      
    ;;
    system)  
      SYSTEM_MODE=1
    ;;
    local) 
      LOCAL_MODE=1
    ;;
    completion)
      INSTALL_COMPLETION=1 
    ;;
    *) 
      echo -e "Skipping invalid option $1\n" 
    ;;
  esac

  shift
  unset MODE
  echo ""
done



wpcli_getopts() {
  MODE=${1:-.}

  DEFAULT_DIR=.
  LOCAL_DIR=.  
  LOCAL_COMP=.
  USR_DIR=$HOME/bin
  USR_COMP=$HOME/.wp-cli
  SYS_DIR=/usr/local/bin
  SYS_COMP=/etc/bash_completion.d 

  CLI_URL=https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 
  COMP_URL=https://raw.githubusercontent.com/wp-cli/wp-cli/v1.5.1/utils/wp-completion.bash  

  case $MODE in
    user)
      DIR=$USR_DIR      
      COMP=$USR_COMP      
    ;;
    system)
      DIR=$SYS_DIR      
      COMP=$SYS_COMP      
    ;;
    local)
      DIR=$LOCAL_DIR      
      COMP=$LOCAL_COMP      
    ;;
    *)
      DIR=$USR_DIR      
      COMP=$USR_COMP      
    ;;
  esac
  
  echo "DIR=$DIR"
  echo "COMP=$COMP" 
  echo "MODE=$MODE"
  echo "COMP_URL=$URL"
  echo "CLI_URL=$URL"

}

# -----------------------------------------------

if [ $SYSTEM_MODE ]; then  

    $(wpcli_getopts system)

    install_wpcli $DIR $MODE $CLI_URL
    if [ $INSTALL_COMPLETION ]; then
        install_wpcli_completion $COMP_DIR $MODE $COMP_URL
    fi

elif [ $USER_MODE ]; then  

    $(wpcli_getopts user) 

    install_wpcli $DIR $MODE $CLI_URL
    if [ $INSTALL_COMPLETION ]; then
        install_wpcli_completion $COMP_DIR $MODE $COMP_URL 
    fi

elif [ $LOCAL_MODE ]; then 

    $(wpcli_getopts local) 

    install_wpcli $DIR $MODE $CLI_URL
    if [ $INSTALL_COMPLETION ]; then
        install_wpcli_completion $COMP_DIR $MODE $COMP_URL
    fi

else 

    $(wpcli_getopts default) 

    install_wpcli $DIR $MODE $CLI_URL
    if [ $INSTALL_COMPLETION ]; then
        install_wpcli_completion $COMP_DIR $MODE $COMP_URL
    fi

fi 
