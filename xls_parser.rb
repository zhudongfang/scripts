#!/usr/bin/env ruby

require 'optparse'
require 'pp'

# options = {}
# OptionParser.new do |opts|
#   opts.banner = 'Usage: Example.rb [options]'
#
#   opts.on('-i', '--input', 'XLS source file path') do |input|
#     options[:input] = input
#   end
#
#   opts.on('-o', '--output', 'Output file path') do |output|
#     options[:output] = output
#   end
#
#   opts.on('-p', '--platform', 'Platform: iOS or Android') do |platform|
#     options[:platform] = platform
#   end
#
#   opts.on('-h', '--help', 'Prints this help') do
#     puts opts
#     exit
#   end
# end.parse!

# puts options
# puts ARGV

class XLSParser
  def self.parse(args)
    options = {}
    opt_parser = OptionParser.new do |opts|
      opts.banner = 'Usage: xls_parser [options]'

      opts.on('-i', '--input', 'XLS source file path') do |input|
        options[:input] = input
      end

      opts.on('-o', '--output', 'Output file path') do |output|
        options[:output] = output
      end

      opts.on('-p', '--platform', 'Platform: iOS or Android') do |platform|
        options[:platform] = platform
      end

      opts.on('-h', '--help', 'Prints this help') do
        puts opts
        exit
      end
    end

    puts opt_parser if !args[0]
    exit

    opt_parser.parse!(args)
    options
  end
end

options = XLSParser.parse(ARGV)
pp options
puts ARGV