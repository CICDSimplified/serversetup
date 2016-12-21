if platform?('ubuntu')
	bash 'update_source_gpg' do
		code <<-EOH
			echo "deb https://packages.elastic.co/beats/apt stable main" |  sudo tee -a /etc/apt/sources.list.d/beats.list
			wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
		EOH
	end
	apt_update 'debain' do
		action :update
	end
	%w{filebeat topbeat packetbeat}.each do |pkg|
		package pkg do
			action :install
		end	
	end
	bash 'update_init' do
		code <<-EOH
			sudo update-rc.d filebeat defaults 95 10
			sudo update-rc.d topbeat defaults 95 10
			sudo update-rc.d packetbeat defaults 95 10
			sudo mkdir -p /etc/pki/tls/certs
		EOH
	end
	template '/etc/filebeat/filebeat.yml' do
		source 'filebeat.erb'
	end
	template '/etc/topbeat/topbeat.yml' do
		source 'topbeat.erb'
	end
	template '/etc/packetbeat/packetbeat.yml' do
		source 'packetbeat.erb'
	end
	template '/etc/pki/tls/certs/logstash-forwarder.crt' do
		source 'logstash-forwarder.erb'
	end
	service 'filebeat' do
		service_name "filebeat"
		action :start
	end
	service 'topbeat' do
		service_name "topbeat"
		action :start
	end
	service 'packetbeat' do
		service_name "packetbeat"
		action :start
	end
end
if platform?('redhat')
	
	bash 'update_source_gpg' do
		code <<-EOH
			rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch			
		EOH
	end
	file '/etc/yum.repos.d/beats.repo' do
		content "[beats]
name=Elastic Beats Repository
baseurl=https://packages.elastic.co/beats/yum/el/$basearch
enabled=1
gpgkey=https://packages.elastic.co/GPG-KEY-elasticsearch
gpgcheck=1"
		action :create
	end
	%w{filebeat topbeat}.each do |pkg|
                package pkg do
                        action :install
                end
        end
	template '/etc/filebeat/filebeat.yml' do
                source 'filebeat.erb'
        end
        template '/etc/topbeat/topbeat.yml' do
                source 'topbeat.erb'
        end
        template '/etc/pki/tls/certs/logstash-forwarder.crt' do
                source 'logstash-forwarder.erb'
        end
        service 'filebeat' do
                service_name "filebeat"
                action :start
        end
        service 'topbeat' do
                service_name "topbeat"
                action :start
        end
end
if platform?('windows')
	windows_package '7zip' do
                source 'http://www.7-zip.org/a/7z938-x64.msi'
                action :install

        end
	powershell_script 'unzip' do
  		code <<-EOH
			cd C:\\Users\\Administrator\\Desktop
  			wget https://download.elastic.co/beats/topbeat/topbeat-1.2.2-windows.zip -OutFile topbeat.zip
			wget https://download.elastic.co/beats/winlogbeat/winlogbeat-1.2.2-windows.zip -OutFile winlogbeat.zip 	
			wget  https://download.elastic.co/beats/packetbeat/packetbeat-1.2.3-windows.zip -OutFile packetbeat.zip
			C:\\"Program Files"\\7-Zip\\7z.exe e C:\\Users\\Administrator\\Desktop\\topbeat.zip  -oC:\\users\\Administrator\\Desktop\\Topbeat -r -y
			C:\\"Program Files"\\7-Zip\\7z.exe e C:\\Users\\Administrator\\Desktop\\winlogbeat.zip  -oC:\\users\\Administrator\\Desktop\\Winlogbeat -r -y
			C:\\"Program Files"\\7-Zip\\7z.exe e C:\\Users\\Administrator\\Desktop\\Packetbeat.zip -oC:\\users\\Administrator\\Desktop\\Packetbeat -r -y
  		EOH
	end
	template 'C:\\Users\\Administrator\\Desktop\\Topbeat\\topbeat.yml' do
		source 'windows_topbeat.erb'
	end
	template 'C:\\Users\\Administrator\\Desktop\\Topbeat\\logstash-forwarder.crt' do
		source 'logstash-forwarder.erb'
	end
	template 'C:\\Users\\Administrator\\Desktop\\Winlogbeat\\winlogbeat.yml' do
                source 'winlogbeat.erb'
        end
	template 'C:\\Users\\Administrator\\Desktop\\Packetbeat\\packetbeat.yml' do
		source 'packetbeat.erb'
	end
        template 'C:\\Users\\Administrator\\Desktop\\Winlogbeat\\logstash-forwarder.crt' do
                source 'logstash-forwarder.erb'
        end
	powershell_script 'copy' do
		code <<-EOH
			mv C:\\Users\\Administrator\\Desktop\\Topbeat C:\\"Program Files"\\Topbeat
			mv C:\\Users\\Administrator\\Desktop\\Winlogbeat C:\\"Program Files"\\Winlogbeat
			mv C:\\Users\\Administrator\\Desktop\\Packetbeat C:\\"Program Files"\\Packetbeat
		EOH
	end
	powershell_script 'install winpcap' do
                code <<-EOH
                        cd C:\\Users\\Administrator\\Desktop
                        wget https://nmap.org/dist/nmap-7.12-win32.zip -OutFile nmap.zip
			C:\\"Program Files"\\7-Zip\\7z.exe e C:\\Users\\Administrator\\Desktop\\nmap.zip  -oC:\\Users\\Administrator\\Desktop\\nmap -r -y
			C:\\Users\\Administrator\\Desktop\\nmap\\winpcap-nmap-4.13.exe /S
		EOH
	end
	 powershell_script 'installation' do
                code <<-EOH
                        C:\\"Program Files"\\Topbeat\\install-service-topbeat.ps1
                        C:\\"Program Files"\\Winlogbeat\\install-service-winlogbeat.ps1
			C:\\"Program Files"\\Packetbeat\\install-service-packetbeat.ps1
                EOH
        end
	windows_service 'topbeat' do
		action :start
		startup_type :automatic
		service_name 'topbeat'
	end
	windows_service 'winlogbeat' do
                action :start
                startup_type :automatic
                service_name 'winlogbeat'
        end

end
