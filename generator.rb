#!/usr/local/bin/ruby
# encoding: utf-8
# author: Rony Xavier rx294@nyu.edu

require 'yaml'
require 'erb'

VARS_YAML = 'vars.yml'
DOC_TEMPLATE = 'doc_template.erb'
TEST_TEMPLATE = 'test_template.erb'

vars = YAML.load_file(VARS_YAML)

def extract_upper_case_letters(string)
  string.scan /\p{Upper}/
end

if vars['singular']
	mock_class_name = "M#{extract_upper_case_letters( vars['class_name']).join}SB"
else
	mock_class_name = "M#{extract_upper_case_letters( vars['class_name']).join}PB"
end

test_code = ERB.new(File.open(TEST_TEMPLATE, "r").read, 0, "%<>").result
docs = ERB.new(File.open(DOC_TEMPLATE, "r").read, 0, "%<>").result

File.open("#{vars['resource_name']}_test.rb", "w+") do |f|
  f.write(test_code)
end

File.open("#{vars['resource_name']}.md", "w+") do |f|
  f.write(docs)
end