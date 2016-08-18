#
# Cookbook Name:: geodns
# Recipe:: default
#
# Copyright 2016, Enrique Jimenez
#
# All rights reserved - Do Not Redistribute
#
extend Rb_manager::Helpers

package "Install geoiplookup command" do
  case node[:platform]
    when 'redhat','centos'
      package_name 'GeoIP'
    when 'ubuntu', 'debian'
      package_name 'geoip-bin'
  end
  action :nothing
end.run_action(:upgrade)

node["geodns"]["domains"].each do |dmn|
  output = get_domain_info(dmn)
  node.default["geodns"]["domains_info"][dmn] = output
end

template node["geodns"]["domains_file"] do
  source "domains_file.erb"
  mode '0644'
  action :create
  variables({ :domains_info => node["geodns"]["domains_info"] })
end


