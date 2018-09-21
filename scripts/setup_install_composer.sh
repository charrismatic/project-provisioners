#!/bin/sh

# local or system
INSTALL_MODE="local" 

# Test Composer Exists
# -----------------------------------------------------------------------------
if ! type "composer" > /dev/null; then

    echo -e "\n--- Installing PHP Composer ---\n"
    cd $HOME/.dev
    
    # Check download script is valid
    # -------------------------------------------------------------------------
    EXPECTED_SIGNATURE="$(wget -q -O - https://composer.github.io/installer.sig)"
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    ACTUAL_SIGNATURE="$(php -r \"echo hash_file('SHA384', 'composer-setup.php');\")"

    # Remove bad result    
    # -------------------------------------------------------------------------
    if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]; then
        >&2 echo 'ERROR: Invalid installer signature'
        rm composer-setup.php
        exit 1
    fi
    
    # Run install script
    # ------------------------------------------------------------------------- 
    php composer-setup.php --quiet
    RESULT=$?
    rm composer-setup.php
    
    # Continue if return code is 0 
    # ------------------------------------------------------------------------- 
    if [ $RESULT = 0 ]; then 
     
      chmod +x composer.phar

      # Move composer to system location 
      # -----------------------------------------------------------------------
      if [ $INSTALL_MODE = "system" ]; then 
          sudo mv composer.phar /usr/local/bin/composer
          chown -R $USER:$USER $HOME/.composer
  
      # Move composer to user local location
      # -----------------------------------------------------------------------
      else
          mv composer.phar $HOME/bin/composer
          chown -R $USER:$USER $HOME/.composer
      fi

    # Exit 
    # -------------------------------------------------------------------------
    else 
      exit $RESULT 
    fi

# Already exists, do nothing
# -----------------------------------------------------------------------------
else

  echo -e "\n--- PHP Composer Already Installed ---\n"
  exit 0
    
fi
