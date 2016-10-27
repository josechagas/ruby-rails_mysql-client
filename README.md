## Supported tags and respective ``Dockerfile`` links

- ``latest`` : [Dockerfile](https://github.com/josechagas/ruby-rails_mysql-client/blob/master/Dockerfile)


Using ``josechagas/rbenv-ruby-rails`` as base image this one was created to execute one ruby on rails application that uses ``Mysql`` as database. This image automatically call the most commom methods necessary to run a ruby on rails application, so basically all you need to do is create the container.

It's important to inform that this image do not has mysql database installed.

## This image contains:
- base image: josechagas/rbenv-ruby-rails
- mysql-client
- libmysqlclient-dev

## Usage:

As I mentioned before this image does not have ``Mysql database`` installed, so before creating the container you need to have a container with mysql database

### - Container with Mysql:

You can use any image of ``Mysql`` you prefer, but I advise you to use the official [mysql](https://hub.docker.com/_/mysql/) image.

- Create the container choosing:
 - a hostname, ``-h [hostname]`` option on ``docker run``
 - the root password
 - and a the name of container (It's optionally, but you will need to remember the name after) 
 
 #### - Using the official mysql image do:
   ```
	docker run --name [container_name] \
          -e MYSQL_ROOT_PASSWORD=[my-secret-pw] \
          -d \ 
          -v /[choose a directory]:/var/lib/mysql \
          -h [choose a hostname]  mysql
   ```

- Add a new user:
This user is going to be used by your ruby on rails application to access the database

 - Access the mysql console, using the root password choosed before:
```
   docker exec -it [container name or id] mysql -p
```
 
 - Create the new user:
 ``Do any kind of modification you fell necessary``
```
GRANT ALL PRIVILEGES ON *.* TO ‘[user_name]’@‘%’ IDENTIFIED BY ‘[user_password]’;
quit;
```
    more informations take a look on [mysql documentation](http://dev.mysql.com/doc/refman/5.7/en/adding-users.html)

### - Configuring my Ruby on Rails Project
- Informing the mysql user info and hostname to ruby on rails project
   Open ``database.yml`` file on ``config`` directory of your project and add the informations
```
  username: [user_name]
  password: [user_password]
  host: [the database container hostname or ip address]
```
   
   more informations take a look on [ruby on rails documentation](http://edgeguides.rubyonrails.org/configuring.html)


### - Creating the Container:

- Do not forget to take a look on ``josechagas/rbenv-ruby-rails`` repository to take some important informations, like how to easily update the base image components.

- Default docker run
```
 docker run -p 3000:3000 -t -a STDOUT \
   --name [choose a name] \ 
   --link [mysql container name]:[some nickname] \ 
   -v /[project directory on host]:/webApp \ 
   josechagas/ruby-rails_mysql-client
```

- Overriding the Workdir:
```
 docker run -p 3000:3000 -t -a STDOUT \
   --name [choose a name] \ 
   --link [mysql container name]:[some nickname] \
   -w [new workdir] \
   -v /[project directory on host]:[new workdir] \
   josechagas/ruby-rails_mysql-client
```

- Overriding the Entrypoint:
```
 docker run -p 3000:3000 -t -a STDOUT \
   --name [choose a name] \ 
   --entrypoint [some method , like bundle install]
   --link [mysql container name]:[some nickname] \ 
   -v /[project directory on host]:/webApp \ 
   josechagas/ruby-rails_mysql-client
```

- Executing with a specific ruby version:
```
docker run -e RBENV_VERSION=[some ruby version] -p 3000:3000 \
   -t -a STDOUT --name [choose a name] \
   --link [mysql container name]:[some nickname]  \
   -v /[project directory on host]:/webApp  \
   josechagas/ruby-rails_mysql-client
```

RBENV_VERSION is a environment variable created by ``rbenv`` package installed in ``josechagas/rbenv-ruby-rails`` base image, It's important to know that the version you want rbenv recognizes.
If you want to see the valid versions call it:
```
rbenv install --list
```

### - About entrypoint script

Located at ``/root`` this shell script exists to execute all necessary things to automate the execution of your project

- To see the content of this file you have some options, for example:
 - Take a look on GitHub repository [ruby-rails_mysql-client](https://github.com/josechagas/ruby-rails_mysql-client)
 - execute the script inside the created container:
```shell
    apt-get install -y nano
    nano /root/entrypoint.sh
```
