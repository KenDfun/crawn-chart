# coding: utf-8

require 'rubypress'

wp = Rubypress::Client.new(
    host: 'www.design-fun.com',
    username: 'okbken',
    password: 'pagewebakari3',
    path: '/wordpress/xmlrpc.php'
)

title = "rubypress3"
content = "<li>ルビーからの投稿</li>"
#cat = ['テスト','stock'] # カテゴリのtag_IDを指定...[1,20,50]のように
#cat = "stock"
tag = "ruby" # カテゴリと同じ様に

post_id = wp.newPost(
    blog_id: 1, #通常は1でOK
    content:{
        post_status: 'publish', #公開:publish　下書き:draft
        post_date: Time.now,
        post_content: content,
        post_title: title,
        terms: {
            category: ['テスト','stock'],
            post_tag: tag,
        }
    }
)

p post_id
#p wp.get
