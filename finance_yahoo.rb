# -*- coding: utf-8 -*-
require 'anemone'
require 'nokogiri'
require 'open-uri'
ddfssdf
urls = []
urls.push("http://stocks.finance.yahoo.co.jp/stocks/chart/?code=8876.T&ct=z&t=6m&q=c&l=off&z=n&p=s,m75,m25&a=v")

class CompanyInfo
	def initialize(ticker_code)
		@baseUrl = "http://stocks.finance.yahoo.co.jp/stocks"
		@tickerCode = ticker_code
		scrape
	end
	attr_reader :name, :tickerCode, :category,
		:unit, :recentHighPrice, :recentLowPrice,
		:highPrice, :lowPrice, :price
=begin
	def get_chart()
		#p test!!!
		url = "#{@baseUrl}/chart/?code=#{@tickerCode}.T&ct=z&t=6m&q=c&l=off&z=n&p=s,m75,m25&a=v"
		companytext = doc.xpath("//*[@id='stockinf']/div[1]/div[2]/tr/th/h1").text
		puts "test"+companytext
	end

=end
dfsdfsefef
	private
	def scrape_stock_info(html, index)
		get_content(html, "dd", "ymuiEditLink mar0", index, "/strong").delete(",")
	end

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
		end
	end

	company = CompanyInfo.new("4689")
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
	company.get_chart


=begin
Anemone.crawl(urls, :depth_limit => 0) do |anemone|
	anemone.on_every_page do |page|

    #文字コードをUTF8に変換したうえで、Nokogiriでパース
    doc = Nokogiri::HTML.parse(page.body.toutf8)

    category = doc.xpath("//*[@id='zg_browseRoot']/ul/li/a").text

	company = doc.xpath("//*[@id='stockinf']/div[1]/div[2]/table/tr/th/h1").text
	price = doc.xpath("//*[@id='stockinf']/div[1]/div[2]/table/tr/td[2]").text

  #カテゴリ名の表示
    sub_category = doc.xpath("//*[@id=\"zg_listTitle\"]/span").text
    puts category+"/"+sub_category

    items = doc.xpath("//div[@class=\"zg_itemRow\"]/div[1]/div[2]")
    items += doc.xpath("//div[@class=\"zg_itemRow\"]/div[2]/div[2]")
    items.each{|item|

  		# 順位
      puts item.xpath("div[1]/span[1]").text

      # 書名
      puts item.xpath("div[\"zg_title\"]/a").text

      # ASIN
      puts item.xpath("div[\"zg_title\"]/a")
      .attribute("href").text.match(%r{dp/(.+?)/})[1]
    }
  end
  endputs page.url
	end
end
=end
