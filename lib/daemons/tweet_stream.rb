#!/usr/bin/env ruby

# You might want to change this
#ENV["RAILS_ENV"] ||= "production"

root = File.expand_path(File.dirname(__FILE__))
root = File.dirname(root) until File.exists?(File.join(root, 'config'))
Dir.chdir(root)

require File.join(root, "config", "environment")
require 'utils'

$running = true
Signal.trap("TERM") do 
  $running = false
end

while($running) do
  Utils::TwitterReader.new.stream
  sleep 10
end
