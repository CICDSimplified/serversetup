bash 'get version from maven' do
	code <<-EOH
		version=$(curl http://172.31.57.19:8081/artifactory/libs-snapshot-local/guru/springframework/spring-boot-web/maven-metadata.xml 2>/dev/null|grep -m 1 value|sed -e 's/<value>//' -e 's/<\\/value>//' -e 's/ //g')
		cd /var/lib/tomcat7/webapps
		wget  http://172.31.57.19:8081/artifactory/libs-snapshot-local/guru/springframework/spring-boot-web/0.0.1-SNAPSHOT/spring-boot-web-$version.war
		mv spring-boot-web-$version.war spring.war
	EOH
end

if platform?('windows')
	powershell_script "backup database for rollback" do
		code <<-EOH
			$date_time = get-date -format dd-M-yyyy
			sqlcmd -E -S  DBSERVER\SQLEXPRESS -Q "BACKUP DATABASE DevOpsAnalytics TO DISK='C:\\chef\\devopsanalytics_$date_time.bak'"
		EOH
	end
end
