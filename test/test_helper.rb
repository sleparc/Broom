$:.unshift File.expand_path('../../lib',  __FILE__)
require 'rubygems'
require 'broom'
require 'test/unit'
require 'shoulda'

def open_file(file_name)
  File.exists?(file_name) ? File.open(file_name) : nil
end
