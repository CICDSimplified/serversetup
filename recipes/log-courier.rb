if platform_family?('rhel')
	remote_file "/etc/yum.repos.d/driskell-log-courier2-epel-6.repo" do
		source 'https://copr.fedoraproject.org/coprs/driskell/log-courier2/repo/epel-6/driskell-log-courier2-epel-6.repo'
		mode '0755'
	end
	package 'log-courier' do
		package_name 'log-courier'
	end
	template '/etc/log-courier/log-courier.conf' do
		source 'log-courier.erb'
		owner 'root'
		group 'root'
		mode '0755'
		notifies :start, 'service[log-courier]', :immediately
	end


end
if platform_family?('debian')
	execute 'updateapt' do
		command 'sudo add-apt-repository ppa:devel-k/log-courier2'
	end
	apt_update 'debian'  do
  		action :update
	end
	package 'log-courier' do
                package_name 'log-courier'
        end
	bash 'create_cert_dir' do
		code <<-EOH
			mkdir -p /etc/pki/tls/certs
		EOH
	end
	template '/etc/pki/tls/certs/logstash-forwarder.crt' do
                source 'logstash-forwarder.erb'
                owner 'root'
                group 'root'
                mode '0755'
       end
	template '/etc/log-courier/log-courier.conf' do
                source 'log-courier.erb'
                owner 'root'
                group 'root'
                mode '0755'  
       end
	service 'log-courier' do
		action :restart
	end
end
