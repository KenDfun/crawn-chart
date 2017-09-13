require 'mime/types'
require 'rubypress'

class WordpressAccess
	def initialize
		@wp = Rubypress::Client.new(
		    host: 'www.design-fun.com',
		    username: 'okbken',
		    password: "pagewebakari3",
		    path: '/wordpress/xmlrpc.php',
		)

		@cat = "stock"
		@tag = "ruby" # カテゴリと同じ様に
		@title = Date.today.strftime("Chart %Y-%x")

	end

	def upload_htmlFile(fileName)
		content = File.open(fileName,'r:utf-8'){|f|
		  f.read
		}
		begin
		post_id = @wp.newPost(
		    blog_id: 1, #通常は1でOK
		    content:{
		        post_status: 'publish', #公開:publish　下書き:draft
		        post_date: Time.now - 32400,
		        post_content: content,
		        post_title: "test",
		        terms: {
		            category: @cat,
		            post_tag: @tag,
		        }
		    }
		)
		rescue XMLRPC::FaultException => e
		  puts "Error"
		  puts e.faultCode
		  puts e.faultString
		end
	end

	def upload_chartFile(fileName)
		fileNamePath = "jpeg/#{fileName}"
		content = File.open(fileNamePath,'rb'){|f|
		  f.read
		}

		retcode = @wp.uploadFile(
		  data: {
		    name: fileName,
		    type: MIME::Types.type_for(fileNamePath).first.to_s,
		    bits: XMLRPC::Base64.new(content)
		  }
		)
		p retcode["url"]
		return retcode["url"]
	end
end

@chartUrl = WordpressAccess.new.upload_chartFile("chart_#{tickerCode}.jpg")
puts @chartUrl
WordpressAccess.new.upload_htmlFile(fileName)
