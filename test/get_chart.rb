require 'open-uri'
require 'openssl'


def get_chart_direct()
	url = "https://chart.yahoo.co.jp/?code=4689.T&tm=6m&type=c&log=off&size=n&over=s,m75,m25&add=v&comp="
	fl = open(url,:ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read
end

get_chart_direct
