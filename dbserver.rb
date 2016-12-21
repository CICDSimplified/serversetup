if platform_family?('linux')
	 bash 'mysql_data' do
                code <<-EOH
                        mkdir -p /data
                EOH
        end

	mysql_service 'default'  do
                version '5.5'
                bind_address '0.0.0.0'
                port 3306
                data_dir '/data'
                initial_root_password 'p@ssw0rd'
                socket '/var/run/mysqld/mysqld.sock'
                action [:create,:start]
	end

	mysql_client 'default' do
                action :create
        end
end


