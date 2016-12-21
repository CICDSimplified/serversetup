if platform?('ubuntu')
	apt_update 'debian' do
		action :update
	end
	bash 'set_mysql_pwd' do
		code <<-EOH
			mkdir -p /data/mysql
			mkdir -p /data/backups
			chown mysql:mysql /data
			sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password p@ssw0rd'
			sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password p@ssw0rd'
		EOH
	end
	package 'mysql' do
		package_name 'mysql-server'
	end
	template  '/etc/mysql/my.cnf' do
		source 'my.erb'
	end
	service 'mysql' do
		service_name 'mysql'
		action :restart
	end
	template '/data/backups/customerdb_customer_details.sql' do
		source 'customerdb_customer_details.erb'
	end
	bash 'create_app_user' do
		code <<-EOH
			mysql -u root -e "CREATE USER 'devops'@'%' IDENTIFIED BY 'passw0rd'"
			mysql -u root -e "GRANT ALL PRIVILEGES ON customerdb . * TO 'devops'@'%'"
			mysql -u root -e "flush privileges"
			mysql -u root -e "create database customerdb"
			mysql -u root customerdb < /data/backups/customerdb_customer_details.sql
		EOH
	end



end
