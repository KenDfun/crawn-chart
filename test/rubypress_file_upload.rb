require 'rubypress'
require 'mime/types'

wp = Rubypress::Client.new(
    host: 'www.design-fun.com',
    username: 'okbken',
    password: "pagewebakari3",
    path: '/wordpress/xmlrpc.php',
)

fileName = 'jpeg/chart_2121.jpg'

content = File.open(fileName,'rb'){|f|
  f.read
}


retcode = wp.uploadFile(
  data: {
    name: 'chart21.jpg',
    type: MIME::Types.type_for(fileName).first.to_s,
    bits: XMLRPC::Base64.new(content)
  }
)

p retcode
