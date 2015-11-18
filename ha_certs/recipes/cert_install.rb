#
# Cookbook Name:: ha_certs
# Recipe:: cert_install
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

Chef::Log.level = :debug

require 'aws-sdk'
include_recipe 'aws'
Aws.use_bundled_cert!

execute "rm #{node["cert_install"]['local_dir']}" do
    command "rm -rf #{node["cert_install"]['local_dir']}"
end

aws_s3_file File.join(node["cert_install"]['local_dir'], node["cert_install"]['remote_path']) do
	bucket node["cert_install"]['bucket']
	remote_path node["cert_install"]['remote_path']
	#s3_url node["cert_install"]['s3_url']
	# cert_install is the name of the app to setup env variables for AWS keys for security
	#aws_access_key_id node[:deploy]['cert_install'][:environment_variables]['aws_access_key_id']
	#aws_secret_access_key node[:deploy]['cert_install'][:environment_variables]['aws_secret_access_key']
	owner 'root'
	group 'root'
	mode '0755'
	#retries 2
end

execute "unzip #{node["cert_install"]['local_file']}" do
    command "unzip #{node["cert_install"]['local_file']}"
    cwd node["cert_install"]['local_dir']
end

execute "rm #{node["cert_install"]['local_file']}" do
    command "rm #{node["cert_install"]['local_file']}"
    cwd node["cert_install"]['local_dir']
end