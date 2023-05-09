##update
apt_update 'update' do
  action :update
end

#install dependencies
package %w(cowsay) do
  action :install
end

############################################
## Ensure that dependencies are installed ##
############################################
execute 'Start...' do
  command '/usr/games/cowsay Provisioning Wordpress in Group'
  live_stream true
end

# Install dependencies
package %w(apache2 ghostscript libapache2-mod-php php php-bcmath php-curl php-imagick php-intl php-json php-mbstring php-mysql php-xml php-zip) do
  action :install
end

########################
## Install wordpress ##
#######################
execute 'wp...' do
  command 'echo =====> Installing WP... '
  live_stream true
end

##create directory to wordpress
directory '/srv/www' do
  owner 'www-data'
  #group 'www-data'
  #mode '0755'
  #action :create
end

##download wordpress
execute 'download_wordpress' do
  cwd '/srv/www/'
  command '/usr/bin/sudo curl https://wordpress.org/latest.tar.gz --output wordpress.tar.gz && /usr/bin/sudo -u www-data tar zxf wordpress.tar.gz'
  #creates '/srv/www/wordpress'
  #user 'root'
  #group 'root'
  #action :run
end

##uncompress wordpress
execute 'download_wordpress' do
  cwd '/srv/www/'
  command '/usr/bin/sudo curl https://wordpress.org/latest.tar.gz --output wordpress.tar.gz && /usr/bin/sudo -u www-data tar zxf wordpress.tar.gz'
  #creates '/srv/www/wordpress'
  #user 'root'
  #group 'root'
  #action :run
end

######################################
## Configurate apache for wordpress ##
######################################
execute 'apache...' do
  command 'echo =====> Configuring APACHE for WP... '
  live_stream true
end

##create file available sites
cookbook_file '/etc/apache2/sites-available/wordpress.conf' do
  source 'wordpress.conf'
  #mode '0644'
  action :create
end

##enable wordpress site
execute 'enable-wordpress-site' do
  command '/usr/bin/sudo a2ensite wordpress && sudo a2enmod rewrite && sudo a2dissite 000-default'
  notifies :reload, 'service[apache2]', :delayed
end

# Start and enable Apache service
service 'apache2' do
  action [:start, :enable]
end

#########################
## Configure database ##
########################
execute 'db...' do
  command 'echo =====> Creating DB... '
  live_stream true
end

mysql_service 'default' do
  port '3306'
  version '8.0'
  initial_root_password 'r00t'
  action [:create, :start]
end

# Create a database
mysql_database node['mysql']['db_name'] do
  host node['mysql']['db_host']
  action :create
  retries 3
  retry_delay 10
end

mysql_user node['mysql']['db_user'] do
  password node['mysql']['db_password']
  database_name node['mysql']['db_name']
  host node['mysql']['db_host']
  privileges [:all]
  action [:create,:grant]
end

####################################
## Connect wordpress to database ##
###################################
execute 'wp_db...' do
  command 'echo =====> Configuring DB for WP... '
  live_stream true
end

template '/srv/www/wordpress/wp-config.php' do
  source 'wp-config-sample.php.erb'
  owner 'www-data'
end

#######################################
## Configurate worpress using wp cli ##
#######################################
execute 'blog...' do
  command 'echo =====> Installing BLOG... '
  live_stream true
end

##install wp-cli
remote_file '/usr/local/bin/wp' do
  source 'https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar'
  mode '0755'
  action :create
end

##install first site
execute 'install_site' do
  cwd '/srv/www/wordpress'
  command "/usr/local/bin/wp core install --url='http://localhost' --title='Devops Master' --admin_name='admin' --admin_password='admin' --admin_email='admin@com.com'"
  user 'www-data'
end

##create first post
execute 'first_post' do
  cwd '/srv/www/wordpress'
  command "/usr/local/bin/wp post create --post_title='Provision WordPress using Vagrant and Chef' --post_content='This deploy was made by Group 😃' --post_status='publish'"
  user 'www-data'
end

#Finishing
execute 'Finishing...' do
  command '/usr/games/cowsay Its Done !'
  only_if "/usr/bin/sudo curl -s localhost | grep -q 'Provision' && echo true || echo false"
  live_stream true
end