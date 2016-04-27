#
# Cookbook Name:: serversetup
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#






package ['tomcat','tomcat-webapps','tomcat-admin-webapps'] do
        case node[:platform]
        when 'redhat', 'centos'
                package_name 'tomcat'
		package_name 'tomcat-webapps'
                package_name 'tomcat-admin-webapps'
        when 'ubuntu', 'debian'
		apt_update 'all platforms'  do
  			action :update
		end
                package_name 'tomcat7'
	when 'windows'
		windows_package '7zip' do
			source 'http://www.7-zip.org/a/7z938-x64.msi'
		end
		remote_file 'file:///c:/Users/Administrator/Documents/apache-tomcat-7.0.69-windows-x64.zip' do
			source 'http://a.mbbsindia.com/tomcat/tomcat-7/v7.0.69/bin/apache-tomcat-7.0.69-windows-x64.zip'
		end
		batch 'echo install tocmat' do
		 code <<-EOH
			7z.exe x file:///c:/Users/Administrator/Documents/apache-tomcat-7.0.69-windows-x64.zip
		EOH
		end

        end
end
service 'tomcat' do
	case node[:platform]
	when 'redhat', 'centos'
		service_name 'tomcat'
	when 'ubuntu', 'debian'
		service_name 'tomcat7'
	end
	action [:start,:enable]
end



