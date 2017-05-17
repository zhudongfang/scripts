#!/usr/bin/env ruby

require 'rubyXL'

XLSX_FILE_PATH = '/Users/zhudf/Develop/Workspace/Python/LesPark/resources/a.xlsx'

workbook = RubyXL::Parser.parse(XLSX_FILE_PATH)
worksheet = workbook.worksheets[0]

worksheet.each do |row|
  next if !row

  cn = row[1].value
  tw = row[3].value
  jp = row[4].value
  en = row[5].value

  key = row[2].value

  next if  !key || key.empty?

  # puts "key=#{key}, cn=#{cn}, tw=#{tw}, jp=#{jp}, en=#{en}"

  r_cn = "\"#{key}\" = \"#{cn}\""

  puts r_cn

end

file = File.new(XLSX_FILE_PATH)

