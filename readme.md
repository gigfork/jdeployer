Simple JavaEE6 app to test deployment with Capistrano

#If you are a Java programmer

1. Install Ruby using RVM or RBENV (Ruby 1.9.3 is preferred)
2. Run "gem install capistrano"
3. Go to your Java project root directory and run "capify"
4. This will create the capistrano config file.
5. Copy the contents of this project's config/deploy.rb to your config/deploy.rb
6. Change the variables file according to your machine
7. Make sure Tomcat is running
8. Make sure Tomcat managers are configured - http://tomcat.apache.org/tomcat-7.0-doc/manager-howto.html#Configuring_Manager_Application_Access
__In your tomcat-users.xml there should be something like -__
user username="tomcat" password="tomcat" roles="manager-gui"
user username="tomcatt" password="tomcatt" roles="manager-script"

9. Run "cap local deploy"

__Note__

You can use this project as a sample Java project to start things off