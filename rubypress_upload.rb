# coding: utf-8

require 'rubypress'

wp = Rubypress::Client.new(
    host: 'www.design-fun.com',
    username: 'okbken',
    password: "pagewebakari3",
    path: '/wordpress/xmlrpc.php',
    port: 80
)

title = "rubypress23"

content = "aaa"
# content = ""
# content = File.open("wordpress.html",'r:utf-8'){|f|
#   f.read
# }
#cat = ['テスト','stock'] # カテゴリのtag_IDを指定...[1,20,50]のように
#cat = "stock"
# tag = "ruby" # カテゴリと同じ様に

begin
post_id = wp.newPost(
    blog_id: 1, #通常は1でOK
    content:{
        post_status: 'publish', #公開:publish　下書き:draft
        post_date: Time.now,
        post_content: content,
        post_title: title,
        terms: {
            category: ['テスト','stock'],
            # post_tag: tag,
        }
    }
)
rescue XMLRPC::FaultException => e
  puts "Error"
  puts e.faultCode
  puts e.faultString
end

#p post_id
#p wp.get
