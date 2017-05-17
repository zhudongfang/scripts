#!/usr/bin/env ruby

require 'RubyXL'

I18N_ROOT_DIR = '/Users/zhudf/LegendPark/lespark_ios/LesPark/lespark_pro'
SRC_ROOT_DIR = '/Users/zhudf/LegendPark/lespark_ios/LesPark'

$i18n_files = []
$code_files = []
$excluded_dir = %w('.' '..')

=begin
<string name="search">搜尋</string>
"search" = "搜寻"
=end

# 遍历
def traverse_dir(path)

  return if !File.directory?(path)

  Dir.foreach(path) do |filename|
    if $excluded_dir.include?(filename)
      next
    end

    file_path = File.join(path, filename)

    traverse_dir(file_path)

    if filename.end_with?('.m')
      $code_files.push(file_path)
    end

    if filename == 'string.xml'
      $i18n_files.push(file_path)
      # process_file(file_path, 'test', 'test_111')
    end
  end

end

# 替换国际化 key
def process_file(file_path, old_key, new_key)
  File.open(file_path) do |fr|
    buffer = fr.read.gsub(/"#{old_key}"/, "\"#{new_key}\"")
    # xcode i18n
    # buffer = fr.read.gsub(/(@"#{old_key}"/, "(@\"#{new_key}\"")
    # objc
    # buffer = fr.read.gsub(/\(@"#{old_key}"/, "(@\"#{new_key}\"")
    File.open(file_path, 'w') { |fw| fw.write(buffer) }
  end
end

def process_i18n_file(old_key, new_key)
  $i18n_files.each do |file|
    process_file(file, "^\"#{old_key}\"", "\"#{new_key}\"")
  end
end

def process_objc_file(old_key, new_key)
  $code_files.each do |file|
    # process_file(file, "(@\"#{old_key}\"", "@\"#{new_key}\"")
    process_file(file, old_key, new_key)
  end
end

def parse_xlsx
  workbook = RubyXL::Parser.parse('key.xlsx')
  worksheet = workbook.worksheets[0]

  total = 0
  count = 0

  worksheet.each do |row|
    next if !row

    total += 1
    new_key     = row[3].value if row[3]
    android_key = row[4].value if row[4]
    ios_key     = row[5].value if row[5]

    old_key = android_key

    next if !new_key || !old_key || new_key.empty? || old_key.empty? || new_key == '#N/A' || old_key == '#N/A'

    # 去掉空格之后再判断是否==
    old_key.strip!
    new_key.strip!

    new_key.gsub(/([a-zA-Z0-9% ]*[a-zA-Z0-9%])/) { |m| puts "#{$1}" }

    puts '111'

    if old_key != new_key
      count += 1
      # puts new_key
      # process_i18n_file(ios_key_value, new_key_value)
    end
  end
  puts "total = #{total}, count = #{count}"
end

# traverse_dir(SRC_ROOT_DIR)
parse_xlsx

