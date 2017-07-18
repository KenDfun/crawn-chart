require 'open-uri'
require 'openssl'

open("https://docs.ruby-lang.org/ja/2.1.0/doc/index.html",:ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE) {|f|
	f.each_line {|line| p line}
}
