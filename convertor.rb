#!/usr/bin/env ruby

require 'optparse'
require './xls_parser'

class Convertor

  def self.parse(args)
    options = {}
    opt_parser = OptionParser.new do |opts|
      opts.banner = 'Usage: convertor [options]'
      opts.separator ''
      opts.separator 'Example: convertor -p ios --sheet 0 --key 0 --value 2,3,4 -i a.xlsx -o i18n.txt'
      opts.separator ''
      opts.separator 'Options'
      opts.separator ''

      opts.on('-i', '--input PATH', 'XLS input file path') do |input|
        options[:input] = input
      end

      opts.on('-o', '--output PATH', 'Output file path') do |output|
        options[:output] = output
      end

      options[:platform] = 'ios'
      opts.on('-p', '--platform [PLATFORM]', 'Platform: iOS or Android') do |platform|
        options[:platform] = platform
      end

      options[:sheet] = 0
      opts.on('--sheet [SHEET]', Integer, 'Index of sheet') do |sheet|
        options[:sheet] = sheet
      end

      opts.on('--key KEY', Integer, 'Column index of i18n key') do |key|
        options[:key] = key
      end

      opts.on('--value A,B,C', Array, 'Column indices of i18n value') do |value|
        options[:value] = value
      end

      options[:verbose] = false
      opts.on('-v', '--verbose', 'Print verbose') do
        options[:verbose] = true
      end

      opts.on('-h', '--help', 'Print this help') do
        puts opts
        exit
      end
    end

    if !args[0]
      puts opt_parser
      exit
    end

    opt_parser.parse!(args)

    # xls_parser = XLSParser.new(
    #                           options[:input],
    #                           options[:output],
    #                           options[:platform],
    #                           options[:sheet],
    #                           options[:key],
    #                           options[:value] )

    xls_parser = XLSParser.new do |p|
      p.xls_path = options[:input]
      p.i18_path = options[:output]
      p.platform = options[:platform]
      p.sheet_index = options[:sheet]
      p.key_index = options[:key]
      p.value_indices = options[:value]
    end
    xls_parser.parse

    options
  end
end

Convertor.parse(ARGV)

