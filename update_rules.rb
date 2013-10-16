#!/usr/bin/env ruby

# Copyright 2013 Vigneshwaran Raveendran (vigneshwaran2007@gmail.com)
#
# Licensed under the Apache License, Version 2.0 (the "License").

require 'rubygems'
require 'aws-sdk'

if ARGV.length != 3
  puts "Usage:-"
  puts "  ruby update_rules.rb <security_group_name> <old_source_ip> <new_source_ip>"
  exit
end

group_name, from, to = ARGV

count = 0

# Instantiate a new client for Amazon Elastic Compute Cloud (EC2). With no
# parameters or configuration, the AWS SDK for Ruby will look for access keys
# and region in these environment variables:
#
#    AWS_ACCESS_KEY_ID='...'
#    AWS_SECRET_ACCESS_KEY='...'
#    AWS_REGION='...'
#
# For more information about this interface to Amazon EC2, see:
# http://docs.aws.amazon.com/AWSRubySDK/latest/AWS/EC2.html
ec2 = AWS::EC2.new

# Although the security group names are unique, the filter method always returns
# an array. The filter method can also support wildcards.
# For more info, refer http://docs.aws.amazon.com/AWSRubySDK/latest/AWS/EC2/SecurityGroupCollection.html#each-instance_method
group = ec2.security_groups.filter('group-name', group_name).first

abort("No such group with the name: #{group_name}") if group == nil

# Get only the inbound rules
ip_permissions = group.ip_permissions

ip_permissions.each do |permission|
  next if not permission.ip_ranges.include? from
  new_ip_ranges = permission.ip_ranges.map { |ip| ip == from ? to : ip }

  # IpPermission objects are immutable so to update a field, we have to
  # create a new instance
  new_ip_permission = AWS::EC2::SecurityGroup::IpPermission.new(
      permission.security_group,
      permission.protocol,
      permission.port_range,
      {
          :ip_ranges => new_ip_ranges,
          :groups => permission.groups
      }
  )

  # Must revoke the old one first before authorizing the new one
  permission.revoke
  new_ip_permission.authorize
  count += 1
end

puts "#{count} rules updated!"
