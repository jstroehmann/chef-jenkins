package "httpd" do
  action :install
end

package "php" do
  action :install
end

service "httpd" do
  action :enable
end

file '/var/www/html/phpinfo.php' do
  owner 'root'
  group 'root'
  mode '0544'
  content '<?php phpinfo(); ?>'
  action :create
end

template '/var/www/html/index.html' do
  owner 'root'
  group 'root'
  mode '0544'
  source 'index.html.erb'
  action :create
end


            "wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo\n",
            "rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key\n",
            "yum -y install jenkins\n",
            "chkconfig jenkins on\n",
            "service jenkins start\n",


            "yum -y install java\n",
            "yum -y install git\n",
            "mkdir /opt/packer/\n",
            "curl -L https://dl.bintray.com/mitchellh/packer/packer_0.7.5_linux_amd64.zip -o /opt/packer/packer_0.7.5_linux_amd64.zip\n",
            "unzip /opt/packer/packer_0.7.5_linux_amd64.zip -d /opt/packer/\n",

            "sleep 30\n",
            "curl -O http://localhost:8080/jnlpJars/jenkins-cli.jar\n",
            "java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin github -deploy\n",
            "java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin instant-messaging -deploy\n",
            "java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin ircbot -restart\n"
