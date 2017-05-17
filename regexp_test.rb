#!/usr/bin/env ruby

old_words = %{@"search_key"}
new_words = %{@"new_search_key"}

str = %{LPLocalizedString(@"search_key", @"Search");}

str.sub!(/LPLocalizedString\(#{old_words}/, "LPLocalizedString(#{new_words}")

# $1 $2.. 在 block 中才能使用
str.sub!(/(LPLocalizedString\()(#{old_words})/) do |x|
  x = "#{$1}#{new_words}"
end

phone = "15510105787"
phone.sub!(/(\d{3})\d{4}(\d{4})/) do
  "#{$1}****#{$2}"
end

# sub 和 gsub 区别在于
# sub 只会替换匹配的第一个
# gsub 全局替换，所有符合条件的都会被替换

md = /(?<foo>\w*?)\d+/.match('abc1234')
puts md[:foo]

str = %{LPLocalizedString(@"search_key", @"Search")  MyLocal(@"search_key")}
reg = %r{(LPLocalizedString|MyLocal)\(@"(?<key>search_key)}
md = str.match(reg)
puts md

puts 'done'
