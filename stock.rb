# -*- coding: utf-8 -*-
require 'nokogiri'
require 'open-uri'

class CompanyInfo
	def initialize
		@baseUrl = "http://stocks.finance.yahoo.co.jp/stocks"
		# @tickerCode = ticker_code
		# scrape
	end

	def info(ticker_code)
		@tickerCode = ticker_code
		scrape
	end

=begin
#old version
	def get_chart()
		url = "#{@baseUrl}/chart/?code=#{@tickerCode}.T&ct=z&t=6m&q=c&l=off&z=n&p=s,m75,m25&a=v"
		p url
		doc = get_nokogiri_doc(url)
		img_url = doc.xpath("//*[@id=\"main\"]/div[6]/img").attribute('src').value
		open("chart_#{tickerCode}.jpg", 'wb') do |file|
			open(img_url) do |data|
				file.write(data.read)
			end
		end
		puts "img: "+img_url
	end
=end
	def get_chart()
		img_url = "http://chart.yahoo.co.jp/?code=#{@tickerCode}.T&tm=6m&type=c&log=off&size=n&over=s,m75,m25&add=v&comp="
		open("jpeg/chart_#{tickerCode}.jpg", 'wb') do |file|
			open(img_url,'rb') do |data|
				file.write(data.read)
			end
		end
	end

	def get_chart_direct()
		url = "http://chart.yahoo.co.jp/?code=#{@tickerCode}.T&tm=6m&type=c&log=off&size=n&over=s,m75,m25&add=v&comp="
		print open(url,'rb').read
	end



	attr_reader :name, :tickerCode, :category,
		:unit, :recentHighPrice, :recentLowPrice,
		:highPrice, :lowPrice, :price

	private
	def get_company_info()
		url = "#{@baseUrl}/profile/?code=#{@tickerCode}"
		doc = get_nokogiri_doc(url)
		@name = doc.xpath("//th[@class='symbol']/h1").text
		@category = doc.xpath("//table[@class='boardFinCom marB6']/tr[6]/td").text
		@unit = doc.xpath("//table[@class='boardFinCom marB6']/tr[13]/td").text
	end

	def get_stock_info()
		url = "#{@baseUrl}/detail/?code=#{@tickerCode}"
		doc = get_nokogiri_doc(url)
		@recentHighPrice = doc.xpath("//div[11]/dl/dd[@class='ymuiEditLink mar0']/strong").text
		@recentLowPrice = doc.xpath("//div[12]/dl/dd[@class='ymuiEditLink mar0']/strong").text
		@highPrice = doc.xpath("//div[@class='innerDate']/div[3]/dl/dd[@class='ymuiEditLink mar0']/strong").text
		@lowPrice = doc.xpath("//div[@class='innerDate']/div[4]/dl/dd[@class='ymuiEditLink mar0']/strong").text
		@price = doc.xpath("//td[@class='stoksPrice']").text
	end

	def get_nokogiri_doc(url)
		begin
			html = open(url)
		rescue OpenURI::HTTPError
			return
		end
		Nokogiri::HTML(html.read, nil, 'utf-8')
	end

	def scrape
		get_company_info
		get_stock_info
		get_chart
	end
end

class TickerCode
	def initialize
		@ticker = []
		for std_ticker in STDIN
			# p std_ticker.to_i
			@ticker.push(std_ticker.to_i)
		end
	end

		attr_reader :ticker
end

class HtmlOut
	def initialize
		@linkName = ""
	end

	def create_Html(tickerCode: 9000, name: '---', highPrice: "---", lowPrice: '---', price: '---')
		@tickerCode = tickerCode
		@name = name
		@highPrice = highPrice
		@lowPrice = lowPrice
		@price = price
		fileName = get_chartName(tickerCode);
		return get_HtmlCode(fileName)
	end

	private

	def get_chartName(tickerCode)
		return "jpeg/chart_#{tickerCode}.jpg"
	end

	def get_HtmlCode(fileName)
		@contents = '<div class="chart_png">
<a href="http://www.design-fun.com/wordpress/wp-content/uploads/2015/09/chart_4689.png"><img class="alignnone size-full wp-image-8" src="http://www.design-fun.com/wordpress/wp-content/uploads/2015/09/chart_4689.png" alt="chart_4689" width="630" height="382"></a>
</div>
<div class="chart_article">
<ul>
<li>yahoo</li>
<li>終値:458</li>
</ul>
</div>
		p fileName
	end
end



#	company = CompanyInfo.new("4689")
#	company.get_chart

tickerCode = TickerCode.new
puts("size = " + tickerCode.ticker.size.to_s)
# p tickerCode.ticker

company = CompanyInfo.new

tickerCode.ticker.each{|code|
	puts("ticker: " + code.to_s)
	company.info(code)
	puts company.name
	puts company.category
	puts company.unit
	puts "年初来高値："+company.recentHighPrice
	puts "年初来安値："+company.recentLowPrice
	puts "高値："+company.highPrice
	puts "安値："+company.lowPrice
	puts "株価："+company.price
	puts "\n"

	HtmlOut.new.create_Html(tickerCode: code, name: company.name, highPrice: company.highPrice, lowPrice: company.lowPrice, price: company.price)


}



#	company.get_chart_direct

=begin
	puts company.name
	puts company.category
	puts company.unit
	puts "年初来高値："+company.recentHighPrice
	puts "年初来安値："+company.recentLowPrice
	puts "高値："+company.highPrice
	puts "安値："+company.lowPrice
	puts "株価："+company.price
=end
