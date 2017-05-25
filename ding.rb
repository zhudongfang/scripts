#!/usr/bin/env ruby

require 'rest-client'
require 'json'

# 文档
# https://open-doc.dingtalk.com/docs/doc.htm?spm=a219a.7629140.0.0.karFPe&treeId=257&articleId=105735&docType=1

DING_WEBHOOK_URL = 'https://oapi.dingtalk.com/robot/send?access_token=d4ee327456b3eb0f6b025f47726dc917409fcecace1bce987a3ff1133baf4a57'

PIC_URL = 'https://oivkbuqoc.qnssl.com/a65301e51000e60796312d5a765163045971152a?t=1495685782.3716035'
FIR_URL = 'http://fir.im/lesparkios'
PGY_URL = 'http://www.pgyer.com/lespark'

version = %x[/usr/libexec/PlistBuddy -c "Print :CFBundleVersion"  /Users/zhudf/jenkins/workspace/LesPark_iOS/build/LesParkFree.app/Info.plist]
# build   = %x[/usr/libexec/PlistBuddy -c "Print :CFBundleShortVersionString" /Users/zhudf/jenkins/workspace/LesPark_iOS/build/LesParkFree.app/Info.plist]

title = "iOS 打包完成, 版本号：v#{version}"
text = "下载地址\nfir.im: #{FIR_URL}\n蒲公英：#{PGY_URL}"

payload = {
    msgtype: 'link',
    link: {
        title: "#{title}",
        text: "#{text}",
        picUrl: "#{PIC_URL}",
        messageUrl: "#{FIR_URL}"
    }
}

# 这种方式在电脑上无法显示
# payload = {
#     msgtype: 'actionCard',
#     actionCard: {
#         title: "#{title}",
#         text: "#{text}",
#         btnOrientation: 0,
#         btns: [
#             {
#               title: 'fir.im',
#               actionURL: "#{FIR_URL}"
#             },
#             {
#               title: '蒲公英',
#               actionURL: "#{PGY_URL}"
#             },
#         ]
#     }
# }

headers = { 'Content-Type' => 'application/json', }

r = RestClient.post(DING_WEBHOOK_URL, payload.to_json, headers)
if r.code == 200
  dict = JSON.parse(r.body)
  puts dict
end
