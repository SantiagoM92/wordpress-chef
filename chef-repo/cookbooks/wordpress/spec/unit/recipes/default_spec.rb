require 'spec_helper'

=begin
Unit test for UBUNTU and CENTOS
=end

describe 'wordpress::default' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu').converge(described_recipe) }
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos').converge(described_recipe) }


  context "with 'default'" do
    it "verify db_name attribute" do
      stub_command("/usr/bin/sudo curl -s localhost | grep -q 'Provision' && echo true || echo false").and_return('true')
      expect(chef_run.node['mysql']['db_name']).to eq('wordpress')
    end

    it "verify db_user attribute" do
      stub_command("/usr/bin/sudo curl -s localhost | grep -q 'Provision' && echo true || echo false").and_return('true')
      expect(chef_run.node['mysql']['db_user']).to eq('wordpress')
    end

    it "verify db_password attribute" do
      stub_command("/usr/bin/sudo curl -s localhost | grep -q 'Provision' && echo true || echo false").and_return('true')
      expect(chef_run.node['mysql']['db_password']).to eq('w0rdpress')
    end

    it "verify db_host attribute" do
      stub_command("/usr/bin/sudo curl -s localhost | grep -q 'Provision' && echo true || echo false").and_return('true')
      expect(chef_run.node['mysql']['db_host']).to eq('localhost')
    end

    it "verify if 'default' recipe is include" do
      stub_command("/usr/bin/sudo curl -s localhost | grep -q 'Provision' && echo true || echo false").and_return('true')
      expect(chef_run).to include_recipe('wordpress::default')
    end

  end

  context "when 'default' recipe exist" do
      it "verify if 'default' recipe is include" do
        stub_command("/usr/bin/sudo curl -s localhost | grep -q 'Provision' && echo true || echo false").and_return('true')
        expect(chef_run).to include_recipe('wordpress::default')
      end
    end
    
  context "when template 'wp-config-sample.php.erb' exists" do
    it 'renders the template' do
      stub_command("/usr/bin/sudo curl -s localhost | grep -q 'Provision' && echo true || echo false").and_return('true')
      expect(chef_run).to render_file('/srv/www/wordpress/wp-config.php').with_content('DB_NAME')
    end
  end

  context "when package 'apache' installed" do
    it 'validate apache package' do
      stub_command("/usr/bin/sudo curl -s localhost | grep -q 'Provision' && echo true || echo false").and_return('true')
      expect(chef_run).to install_package('apache2, ghostscript, libapache2-mod-php, php, php-bcmath, php-curl, php-imagick, php-intl, php-json, php-mbstring, php-mysql, php-xml, php-zip')
    end
  end

  context "when service 'apache'" do
    it 'validate start apache service' do
      stub_command("/usr/bin/sudo curl -s localhost | grep -q 'Provision' && echo true || echo false").and_return('true')
      expect(chef_run).to start_service('apache2')
    end

    it 'validate enable apache service' do
      stub_command("/usr/bin/sudo curl -s localhost | grep -q 'Provision' && echo true || echo false").and_return('true')
      expect(chef_run).to enable_service('apache2')
    end
  end

end


