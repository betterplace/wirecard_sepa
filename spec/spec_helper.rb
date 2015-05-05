require 'simplecov'
require 'byebug'

# FIXME
# SimpleCov.adapters.define 'gem' do
#   add_filter '/spec/'
#   add_filter '/autotest/'
#   add_group 'Libraries', '/lib/'
# end
# SimpleCov.start 'gem'
def read_support_file(file_path)
  File.read File.expand_path("../support/#{file_path}", __FILE__)
end

require 'wirecard_sepa'
