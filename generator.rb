require 'yaml'
require 'erb'

elements = YAML.load_file('vars.yml')

def extract_upper_case_letters(string)
  string.scan /\p{Upper}/
end

mock_class_name = "M#{extract_upper_case_letters( elements['class_name']).join}SB"

test_template = %q{
require 'helper'
require '<%= elements['resource_name'] %>'

# <%= mock_class_name %> = Mock<%= elements['class_name'] %>Backend
# Abbreviation not used outside this file

#=============================================================================#
#                            Constructor Tests
#=============================================================================#
class <%= elements['class_name'] %>ConstructorTest < Minitest::Test

  def setup
    <%= elements['class_name'] %>::BackendFactory.select(<%= mock_class_name %>::Empty)
  end
  <% if elements['empty_param_ok'] %>
  def test_accepts_empty_params
    <%=elements['class_name']%>.new
  end
  <% else %>
  def test_rejects_empty_params
    assert_raises(ArgumentError) { <%=elements['class_name']%>.new }
  end
  <% end %>
  <% if elements['scalar_param_ok'] %>
  def test_accepts_<%=elements['param_name'] %>_as_scalar
    <%=elements['class_name']%>.new('<%=elements['assert_param'] %>')
  end
  <% else %>
  def test_rejects_empty_params
    assert_raises(ArgumentError) { <%=elements['class_name']%>.new('_<%=elements['assert_param'] %>') }
  end
  <% end %>
  <% if elements['param_name'] %>
  def test_accepts_<%=elements['param_name'] %>_as_hash
    <%=elements['class_name']%>.new(<%=elements['param_name'] %>: '<%=elements['assert_param'] %>')
  end
  <% end %>
  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { <%=elements['class_name']%>.new(invalid: 9) }
  end
end

#=============================================================================#
#                               Search / Recall
#=============================================================================#
class <%=elements['class_name']%>RecallTest < Minitest::Test

  def setup
    <%=elements['class_name']%>::BackendFactory.select(<%= mock_class_name %>::Basic)
  end
  <% if elements['scalar_param_ok'] %>
  def test_search_hit_via_scalar_works
    assert <%=elements['class_name']%>.new('<%=elements['assert_param']%>').exists?
  end
  <% end %>
  <% if elements['param_name'] %>
  def test_search_hit_via_hash_works
    assert <%=elements['class_name']%>.new(<%=elements['param_name']%>: '<%=elements['assert_param']%>').exists?
  end
  <% end %>
  <% if elements['param_name'] %>
  def test_search_miss_is_not_an_exception
    refute <%=elements['class_name']%>.new(<%=elements['param_name']%>: 'non-existant').exists?
  end
  <% end %>
end

#=============================================================================#
#                               Properties
#=============================================================================#
class <%=elements['class_name']%>PropertiesTest < Minitest::Test

  def setup
    <%=elements['class_name']%>::BackendFactory.select(<%= mock_class_name %>::Basic)
  end

  <% elements['properties'].each do |property| %>
  def test_property_<%=property%>
    assert_equal('CHANGE_ME', <%=elements['class_name']%>.new('<%=elements['assert_param']%>').<%=property%>)
    assert_nil(<%=elements['class_name']%>.new(<%=elements['param_name']%>: 'non-existant').<%=property%>)
  end
  <% end %>
end


#=============================================================================#
#                               Matchers
#=============================================================================#
class <%=elements['class_name']%>MatchersTest < Minitest::Test

  def setup
    <%=elements['class_name']%>::BackendFactory.select(<%= mock_class_name %>::Basic)
  end
  <% elements['matchers'].each do |matcher| %>
  def test_matcher_<%=matcher%>_positive
    assert <%=elements['class_name']%>.new('<%=elements['assert_param']%>').<%=matcher%>?
  end

  def test_matcher_<%=matcher%>_negative
    refute <%=elements['class_name']%>.new('<%=elements['refute_param']%>').<%=matcher%>?
  end
  <% end %>
end


#=============================================================================#
#                               Test Fixtures
#=============================================================================#
module <%= mock_class_name %>
  class Empty < <%=elements['class_name']%>::Backend
    def CHANGE_ME(query)
      OpenStruct.new(CHANGE_ME: [])
    end
  end

  class Basic < <%=elements['class_name']%>::Backend
    def CHANGE_ME(query)
      fixtures = [
      ]
      OpenStruct.new({ CHANGE_ME: fixtures })
    end
  end
end
}


doc_template = %q{

---
title: About the aws_cloudwatch_alarm Resource
---

# <%=elements['resource_name']%>

ADD_DESCRIPTION

<br>

## Syntax

ADD_DESCRIPTION

    # Find a CHANGEME by name
    describe <%=elements['resource_name']%>('<%=elements['assert_param']%>') do
      it { should exist }
    end

    # Hash syntax for CHANGEME name
    describe <%=elements['resource_name']%>(trail_name: '<%=elements['assert_param']%>') do
      it { should exist }
    end

<br>

## Examples

The following examples show how to use this InSpec audit resource.

### ADD_DESCRIPTION

    describe <%=elements['resource_name']%>('<%=elements['assert_param']%>') do
      it { should exist }
    end

### ADD_DESCRIPTION

    describe <%=elements['resource_name']%>('<%=elements['assert_param']%>') do
      it { should CHANGEME }
    end

### ADD_DESCRIPTION

    describe <%=elements['resource_name']%>('<%=elements['assert_param']%>') do
      it { should CHANGEME }
    end

<br>

## Properties

<% elements['properties'].each do |property| %>
### <%=property%>

ADD_DESCRIPTION

    describe <%=elements['resource_name']%>('<%=elements['assert_param']%>') do
      its('<%=property%>') { should cmp "CHANGEME" }
    end

<% end %>

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers (such as `exist`) please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

<% elements['matchers'].each do |matcher| %>

### be_<%=matcher%>

ADD_DESCRIPTION

    describe <%=elements['resource_name']%>('<%=elements['assert_param']%>') do
      it { should be_<%=matcher%> }
    end

<% end %>

}

test_code = ERB.new(test_template, 0, "%<>").result
docs = ERB.new(doc_template, 0, "%<>").result

File.open("#{elements['resource_name']}_test.rb", "w+") do |f|
  f.write(test_code)
end

File.open("#{elements['resource_name']}.md", "w+") do |f|
  f.write(docs)
end