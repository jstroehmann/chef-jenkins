template '/etc/yum.repos.d/jenkins.repo' do
  owner 'root'
  group 'root'
  mode '0544'
  source 'jenkins.repo.erb'
  action :create
end

execute 'install_jenkins_key' do
  command 'rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key'
end


package ['jenkins', 'git'] do
  action :install
end

service 'jenkins' do
  action [:enable, :start]
end

directory '/opt/packer' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

remote_file '/opt/packer/packer_0.7.5_linux_amd64.zip' do
  source 'https://dl.bintray.com/mitchellh/packer/packer_0.7.5_linux_amd64.zip'
end

execute 'install_packer' do
  command 'unzip /opt/packer/packer_0.7.5_linux_amd64.zip -d /opt/packer/'
end

bash 'install_jenkins_plugins' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
  sleep 30
  curl -O http://localhost:8080/jnlpJars/jenkins-cli.jar
  java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin github -deploy
  java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin instant-messaging -deploy
  java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin ircbot -restart
  EOH
end
