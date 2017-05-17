#!/usr/bin/env ruby

require 'rest-client'
require 'json'

headers = {
  'user_id'  => '558a8a6367baa66fcf9e17c0',
  'token' => '5e73f585923fa9757c6b942a415b2932',
  'locale'   => 'CN',
  'bundle_id' => 'PeonyPark.LesParkFree',
  'device_id' => 'iPhone',
  'device_model' => '',
  'device_os' => '10.2.1',
  'free' => '1',
  'version' => '6.1.6'
}

url = 'lapi.gaypark.cn/v2/online'

isInterrupt = false
count = 0

while !isInterrupt
  r = RestClient.get(url, headers=headers)
  count += 1
  if r.code == 200
    dict = JSON.parse(r.body)
    if dict['error'].to_i == 0
      user_sign = dict['data']['tc_im_user_sig']
      if user_sign.empty?
        isInterrupt = true
        puts 'user sign is empty'
      else
        puts "user sign [#{count}]: #{user_sign}"
      end
    else
      puts 'error: ' + dict[:msg]
    end
  elsif
  puts r.error
  end
end
