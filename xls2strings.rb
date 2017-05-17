#!/usr/bin/env ruby

require 'rubyXL'

# 1. 在不同缩进的代码之间，不要使用空行分隔
# 2. 在各个段落之间，使用一个空行分隔

# iOS     => "key" = "value";
# Android => <string name="key">value</string>

XLSX_FILE_PATH = './resources/630.xlsx'
I18N_FILE_PATH = './resources/i18n.txt'

# ios or android
$platform = 'ios'
$config = [
    { lang: 'CN', key_index: 1, value_index: 2, sheet_index: 0 },
    { lang: 'TW', key_index: 1, value_index: 3, sheet_index: 0 },
    { lang: 'EN', key_index: 1, value_index: 4, sheet_index: 0 },
]

def extract
  workbook = RubyXL::Parser.parse(XLSX_FILE_PATH)

  file = File.open(I18N_FILE_PATH, 'w+') # 追加'a+'

  $config.each do |c|
    key_index = c[:key_index]
    value_index = c[:value_index]
    sheet_index = c[:sheet_index]

    worksheet = workbook[sheet_index]
    worksheet.each do |row|
      key = row[key_index].value
      value = row[value_index].value

      next unless key

      key.strip!
      value.strip! if value

      kv = if $platform.downcase == 'ios'
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

def isValid(str)
  str && !str.empty?
end


# Main
extract
