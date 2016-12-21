if platform?('ubuntu')
	bash 'update_source_gpg' do
		code <<-EOH
			echo 'deb http://packages.elasticsearch.org/logstashforwarder/debian stable main' | sudo tee /etc/apt/sources.list.d/logstashforwarder.list
			 wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -
		EOH
	end
	apt_update 'debain' do
		action :update
	end
	package 'logstash_forwarder' do
		package_name 'logstash-forwarder'
	end
	bash 'update_init' do
		code <<-EOH
			cd /etc/init.d/; sudo wget https://raw.githubusercontent.com/elasticsearch/logstash-forwarder/a73e1cb7e43c6de97050912b5bb35910c0f8d0da/logstash-forwarder.init -O logstash-forwarder
			sudo chmod +x logstash-forwarder
			sudo update-rc.d logstash-forwarder defaults
			mkdir -p /etc/pki/tls/certs
		EOH
	end
	template '/etc/logstash-forwarder' do
		source 'logstash-forwarder-config.erb'
	end
	template '/etc/pki/tls/certs/logstash-forwarder.crt' do
		source 'logstash-forwarder.erb'
	end
	service 'logstash-forwarder' do
		service_name "logstash-forwarder"
		action :start
	end
end

