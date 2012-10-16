require 'rubygems'
require 'lib/broom'
# require File.join(File.dirname(__FILE__), '..', 'lib', 'broom')

if ARGV.size == 0
  puts "Please enter a filename"
else
  ARGV.each do |arg|
    if !File.exists?(arg.to_s)
      puts "No such file - " + arg.to_s
    else
      file = File.open(arg.to_s)
      blocks = Alphabetize.retrieve_block(file)
      file.close
      filename = "output_#{rand 100}.css"
      output = File.new(filename, "w")
      output.puts(blocks)
      output.close
      puts "OUTPUT WAS PLACED IN: " + filename
    end
  end
end
