# inspec_aws_test_doc_generator
Generates Test and documentations skeletons for inspec_aws resources

If you are tired of writing test code and docs for new resouces please use this tool

## Get Started

Complete the vars.yml file

Example

```
resource_name: "aws_cloudtrail_trail"
class_name: "AwsCloudTrailTrail"

# true if empty params are ok
empty_param_ok: false

# true if scalar params are ok
scalar_param_ok: true

param_name: "trail_name"

assert_param: "test-trail-1"
refute_param: "non-existant"

properties: [
  "s3_bucket_name",
  "trail_arn",
  "cloud_watch_logs_role_arn",
  "cloud_watch_logs_log_group_arn",
  "kms_key_id",
  "home_region"
]

#specify the matcher methods without '?'
# examples
# encrypted? => encrypted
# attached_to_user?('test-user') => attached_to_user
# params for the method in the above line has to be manually added

matchers: [
  "encrypted",
  "multi_region_trail",
  "log_file_validation_enabled",
]
```

## Run

```
ruby generator.rb
```

Files generated 
- resource_name.md
- resource_name_trail_test.rb

## Notes

Look for `CHANGEME` and `ADD_DESCRIPTION` in the files.

## Feedback

This is a very limited tool at this point...contributions are welcome.