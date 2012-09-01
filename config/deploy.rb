set :application, "jdeployer"
set :scm, "git"
set :repository, "git@github.com:rocky-jaiswal/#{application}.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

task :local do
    roles.clear
    server "localhost", :app
    set :user, "rockyj"
    set :java_home, "/home/#{user}/jdk1.7.0_05"
    set :tomcat_home, "/home/#{user}/Apps/apache-tomcat-7.0.29"
    set :tomcat_manager, "manager"
    set :tomcat_manager_password, "manager"
    set :maven_home, "/home/#{user}/Apps/apache-maven-3.0.4"
    set :deploy_to, "/home/#{user}/tmp/#{application}"
    set :use_sudo, false
    namespace :tomcat do
      task :deploy do
        puts "==================Building with Maven======================"
        run "export JAVA_HOME=#{java_home} && cd #{deploy_to}/current && #{maven_home}/bin/mvn clean package"
        puts "==================Undeploy war======================"
        run "curl --user #{tomcat_manager}:#{tomcat_manager_password} http://$CAPISTRANO:HOST$:8080/manager/text/undeploy?path=/#{application}"
        puts "==================Deploy war to Tomcat======================"
        run "curl --upload-file #{deploy_to}/current/target/#{application}*.war --user #{tomcat_manager}:#{tomcat_manager_password} http://$CAPISTRANO:HOST$:8080/manager/text/deploy?path=/#{application}"
      end
    end
    after "deploy", "tomcat:deploy"
    after "tomcat:deploy", "deploy:cleanup" # keep only the last 5 releases
end
