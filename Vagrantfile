
Vagrant.configure("2") do |config|

  config.vm.define "wordpress"

  config.vm.network "forwarded_port", guest: 80, host: 80
  config.vm.network "private_network", ip: "192.168.33.10"

  if Vagrant::Util::Platform.windows?
    config.vm.provider "virtualbox" do |vb|
    end
    config.vm.box_download_insecure=true
    config.vm.box = "bento/ubuntu-20.04"
  elsif Vagrant::Util::Platform.darwin?
    config.vm.provider "parallels" do |p|
    end
    config.vm.box = "bento/ubuntu-20.04-arm64"
  elsif Vagrant::Util::Platform.linux?
    config.vm.provider "virtualbox" do |vb|
    end
    config.vm.box = "bento/ubuntu-20.04"
  end

   config.vm.provision "shell", inline: <<-SHELL
     apt-get update
	   curl -L https://chef.io/chef/install.sh | sudo bash
     curl -L https://supermarket.chef.io/cookbooks/mysql/download | tar -xz -C /vagrant/chef-repo/cookbooks/
     curl -L https://supermarket.chef.io/cookbooks/apparmor/download | tar -xz -C /vagrant/chef-repo/cookbooks/
     curl -L https://supermarket.chef.io/cookbooks/line/download | tar -xz -C /vagrant/chef-repo/cookbooks/
   SHELL

   # IMPORTANTE => https://github.com/hashicorp/vagrant/issues/12337
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "chef-repo/cookbooks"
    chef.add_recipe "wordpress"
    chef.arguments = "--chef-license accept"
    chef.install = false
  end

end
