require 'chef/provisioning/aws_driver'

with_driver 'aws::us-east-1' do
  with_machine_options :ssh_username => 'ec2-user',
    :bootstrap_options => {      
      :image_id => 'ami-2051294a',
      :key_name => 'cdsimplified',
      :instance_type => 't2.micro',
      :security_group_ids => 'sg-c92d84b1'
    }

machine_batch do
  machine'web-box-11' do
    converge true
    recipe 'serversetup::install-packages'
  end

  machine'web-box-12' do
    converge true
    recipe 'serversetup::install-packages'
  end
end



end

