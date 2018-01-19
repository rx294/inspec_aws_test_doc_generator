require 'helper'
require 'aws_cloudtrail_trail'

# MACTTSB = MockAwsCloudTrailTrailSingularBackend
# Abbreviation not used outside this file

#=============================================================================#
#                            Constructor Tests
#=============================================================================#
class AwsCloudTrailTrailConstructorTest < Minitest::Test

  def setup
    AwsCloudTrailTrail::BackendFactory.select(MACTTSB::Empty)
  end
  
  def test_rejects_empty_params
    assert_raises(ArgumentError) { AwsCloudTrailTrail.new }
  end
  
  
  def test_accepts_trail_name_as_scalar
    AwsCloudTrailTrail.new('test-trail-1')
  end
  
  
  def test_accepts_trail_name_as_hash
    AwsCloudTrailTrail.new(trail_name: 'test-trail-1')
  end
  
  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsCloudTrailTrail.new(invalid: 9) }
  end
end

#=============================================================================#
#                               Search / Recall
#=============================================================================#
class AwsCloudTrailTrailRecallTest < Minitest::Test

  def setup
    AwsCloudTrailTrail::BackendFactory.select(MACTTSB::Basic)
  end
  
  def test_search_hit_via_scalar_works
    assert AwsCloudTrailTrail.new('test-trail-1').exists?
  end
  
  
  def test_search_hit_via_hash_works
    assert AwsCloudTrailTrail.new(trail_name: 'test-trail-1').exists?
  end
  
  
  def test_search_miss_is_not_an_exception
    refute AwsCloudTrailTrail.new(trail_name: 'non-existant').exists?
  end
  
end

#=============================================================================#
#                               Properties
#=============================================================================#
class AwsCloudTrailTrailPropertiesTest < Minitest::Test

  def setup
    AwsCloudTrailTrail::BackendFactory.select(MACTTSB::Basic)
  end

  
  def test_property_s3_bucket_name
    assert_equal('CHANGE_ME', AwsCloudTrailTrail.new('test-trail-1').s3_bucket_name)
    assert_nil(AwsCloudTrailTrail.new(trail_name: 'non-existant').s3_bucket_name)
  end
  
  def test_property_trail_arn
    assert_equal('CHANGE_ME', AwsCloudTrailTrail.new('test-trail-1').trail_arn)
    assert_nil(AwsCloudTrailTrail.new(trail_name: 'non-existant').trail_arn)
  end
  
  def test_property_cloud_watch_logs_role_arn
    assert_equal('CHANGE_ME', AwsCloudTrailTrail.new('test-trail-1').cloud_watch_logs_role_arn)
    assert_nil(AwsCloudTrailTrail.new(trail_name: 'non-existant').cloud_watch_logs_role_arn)
  end
  
  def test_property_cloud_watch_logs_log_group_arn
    assert_equal('CHANGE_ME', AwsCloudTrailTrail.new('test-trail-1').cloud_watch_logs_log_group_arn)
    assert_nil(AwsCloudTrailTrail.new(trail_name: 'non-existant').cloud_watch_logs_log_group_arn)
  end
  
  def test_property_kms_key_id
    assert_equal('CHANGE_ME', AwsCloudTrailTrail.new('test-trail-1').kms_key_id)
    assert_nil(AwsCloudTrailTrail.new(trail_name: 'non-existant').kms_key_id)
  end
  
  def test_property_home_region
    assert_equal('CHANGE_ME', AwsCloudTrailTrail.new('test-trail-1').home_region)
    assert_nil(AwsCloudTrailTrail.new(trail_name: 'non-existant').home_region)
  end
  
end


#=============================================================================#
#                               Matchers
#=============================================================================#
class AwsCloudTrailTrailMatchersTest < Minitest::Test

  def setup
    AwsCloudTrailTrail::BackendFactory.select(MACTTSB::Basic)
  end
  
  def test_matcher_encrypted_positive
    assert AwsCloudTrailTrail.new('test-trail-1').encrypted?
  end

  def test_matcher_encrypted_negative
    refute AwsCloudTrailTrail.new('non-existant').encrypted?
  end
  
  def test_matcher_multi_region_trail_positive
    assert AwsCloudTrailTrail.new('test-trail-1').multi_region_trail?
  end

  def test_matcher_multi_region_trail_negative
    refute AwsCloudTrailTrail.new('non-existant').multi_region_trail?
  end
  
  def test_matcher_log_file_validation_enabled_positive
    assert AwsCloudTrailTrail.new('test-trail-1').log_file_validation_enabled?
  end

  def test_matcher_log_file_validation_enabled_negative
    refute AwsCloudTrailTrail.new('non-existant').log_file_validation_enabled?
  end
  
end


#=============================================================================#
#                               Test Fixtures
#=============================================================================#
module MACTTSB
  class Empty < AwsCloudTrailTrail::Backend
    def CHANGE_ME(query)
      OpenStruct.new(CHANGE_ME: [])
    end
  end

  class Basic < AwsCloudTrailTrail::Backend
    def CHANGE_ME(query)
      fixtures = [
      ]
      OpenStruct.new({ CHANGE_ME: fixtures })
    end
  end
end