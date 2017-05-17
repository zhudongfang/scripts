#!/usr/bin/env ruby


File.open('a.txt', 'r') do |f|
  f.foreach do |line|
    puts line
  end
end

