#image name: josechagas/ruby-rails_mysql-client

FROM josechagas/rbenv-ruby-rails

MAINTAINER José Lucas <chagasjoselucas@gmail.com>

####### Copying the script to be executed on entrypoint

COPY entrypoint.sh /root/ruby-rails_mysql-client/entrypoint.sh

RUN chmod +x /root/ruby-rails_mysql-client/entrypoint.sh

#######

####### Installing things necessary to communicate with mysql server
RUN apt-get install -y mysql-client libmysqlclient-dev
#######

####### Defines WORKDIR

WORKDIR /webApp

####### Start the server and run the ruby application on this WORKDIR


ENTRYPOINT /root/ruby-rails_mysql-client/entrypoint.sh

#Use RBENV_VERSION environment variable if you want to install and set another current version