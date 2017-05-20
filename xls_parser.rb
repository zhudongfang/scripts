#!/usr/bin/env ruby

require 'rubyXL'
require 'pathname'

# 1. 在不同缩进的代码之间，不要使用空行分隔
# 2. 在各个段落之间，使用一个空行分隔

class XLSParser

  attr_accessor :xls_path, :i18_path, :platform, :sheet_index, :key_index, :value_indices

  def initialize
    yield self
  end

  # def initialize(xls_path, i18n_path, platform, sheet_index, key_index, value_indices)
  #   @xls_path = xls_path
  #   @i18_path = i18n_path
  #   @platform = platform
  #   @sheet_index   = sheet_index
  #   @key_index     = key_index
  #   @value_indices = value_indices
  # end

  def parse
    workbook = RubyXL::Parser.parse(@xls_path)
    worksheet = workbook[@sheet_index]

    file = File.open(@i18_path, 'w+') # 追加'a+'

    @value_indices.each do |index|

      value_index = if index.is_a? Numeric
                      index
                    else
                      index.to_i
                    end

      worksheet.each do |row|
        key = row[@key_index].value
        value = row[value_index].value

        next unless key

        key.strip!
        value.strip! if value

        # iOS     => "key" = "value";
        # Android => <string name="key">value</string>
        kv = if @platform.downcase == 'ios'
               "\"#{key}\" = \"#{value}\";"
             else
               "<string name=\"#{key}\">#{value}</string>"
             end

        # Write
        file.puts kv
      end

      file.puts "\n\n\n"
    end

    file.close
  end
end

