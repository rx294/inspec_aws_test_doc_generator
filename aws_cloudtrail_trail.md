

  ---
title: About the aws_cloudtrail_trail Resource
---

# aws_cloudtrail_trail

ADD_DESCRIPTION

<br>

## Syntax

ADD_DESCRIPTION

    # Find a CHANGEME by name
    describe aws_cloudtrail_trail('test-trail-1') do
      it { should exist }
    end

    # Hash syntax for CHANGEME name
    describe aws_cloudtrail_trail(trail_name: 'test-trail-1') do
      it { should exist }
    end

<br>

## Examples

The following examples show how to use this InSpec audit resource.

### ADD_DESCRIPTION

    describe aws_cloudtrail_trail('test-trail-1') do
      it { should exist }
    end

### ADD_DESCRIPTION

    describe aws_cloudtrail_trail('test-trail-1') do
      it { should CHANGEME }
    end

### ADD_DESCRIPTION

    describe aws_cloudtrail_trail('test-trail-1') do
      it { should CHANGEME }
    end

<br>

## Properties

### s3_bucket_name

ADD_DESCRIPTION

    describe aws_cloudtrail_trail('test-trail-1') do
      its('s3_bucket_name') { should cmp "CHANGEME" }
    end

### trail_arn

ADD_DESCRIPTION

    describe aws_cloudtrail_trail('test-trail-1') do
      its('trail_arn') { should cmp "CHANGEME" }
    end

### cloud_watch_logs_role_arn

ADD_DESCRIPTION

    describe aws_cloudtrail_trail('test-trail-1') do
      its('cloud_watch_logs_role_arn') { should cmp "CHANGEME" }
    end

### cloud_watch_logs_log_group_arn

ADD_DESCRIPTION

    describe aws_cloudtrail_trail('test-trail-1') do
      its('cloud_watch_logs_log_group_arn') { should cmp "CHANGEME" }
    end

### kms_key_id

ADD_DESCRIPTION

    describe aws_cloudtrail_trail('test-trail-1') do
      its('kms_key_id') { should cmp "CHANGEME" }
    end

### home_region

ADD_DESCRIPTION

    describe aws_cloudtrail_trail('test-trail-1') do
      its('home_region') { should cmp "CHANGEME" }
    end


## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers (such as `exist`) please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).


### be_encrypted

ADD_DESCRIPTION

    describe aws_cloudtrail_trail('test-trail-1') do
      it { should be_encrypted }
    end


### be_multi_region_trail

ADD_DESCRIPTION

    describe aws_cloudtrail_trail('test-trail-1') do
      it { should be_multi_region_trail }
    end


### be_log_file_validation_enabled

ADD_DESCRIPTION

    describe aws_cloudtrail_trail('test-trail-1') do
      it { should be_log_file_validation_enabled }
    end


