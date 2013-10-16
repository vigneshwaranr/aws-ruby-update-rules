# AWS Ruby Update Rules

A simple Ruby script that updates the ip addresses of inbound rules of a specified security group in your Amazon EC2 instance.

## Requirements

The only requirement of this script is [aws-sdk](http://aws.amazon.com/sdkforruby/).

You can install the SDK directly with:

    gem install aws-sdk

## Basic Configuration

You need to set your AWS security credentials before the script
is able to connect to AWS. The AWS SDK for Ruby will automatically read these from the environment:

    export AWS_ACCESS_KEY_ID='...'
    export AWS_SECRET_ACCESS_KEY='...'
    export AWS_REGION='...'

See the [Security Credentials](http://aws.amazon.com/security-credentials) page
for more information on getting your keys.

## Running the script

This sample application connects to Amazon's [Elastic Compute Cloud (EC2)](http://aws.amazon.com/ec2),
finds the security group with the specified name, and updates the ip addresses of inbound rules as you specified.
Run it as:

    ruby update_rules.rb <security_group_name> <old_source_ip> <new_source_ip>

## Screenshots
* Running the script in command line
![screenshot 2](https://raw.github.com/vigneshwaranr/aws-ruby-update-rules/master/screenshots/ec2_2.png "Screenshot that shows how to run this script in command line")

* Before running this script
![screenshot 1](https://raw.github.com/vigneshwaranr/aws-ruby-update-rules/master/screenshots/ec2_1.png "Screenshot that shows my security group before running this script")

* After running this script
![screenshot 3](https://raw.github.com/vigneshwaranr/aws-ruby-update-rules/master/screenshots/ec2_3.png "Screenshot that shows my security group before running this script")

## Credits
Thanks to [awslabs/aws-ruby-sample](https://github.com/awslabs/aws-ruby-sample) for getting me started.
