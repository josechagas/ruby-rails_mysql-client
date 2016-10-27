# se nao e a version system e nao esta instalada ainda

if [ "$RBENV_VERSION" != "system" ] && [ "$RBENV_VERSION" != "" ]; then
	
	echo "Looking if it's necessary to install the ruby version $RBENV_VERSION"
	#install but if its appear to be installed do not install it (-s)
	if rbenv install -s $RBENV_VERSION ; then
		rbenv global $RBENV_VERSION
	else
		echo "Failed to install the specified ruby version"
	fi
elif [ "$RBENV_VERSION" != "" ]; then
	rbenv global $RBENV_VERSION
fi
bundle install
rake db:create
rake db:migrate
rm -f /webApp/tmp/pids/server.pid
rails server -b 0.0.0.0

