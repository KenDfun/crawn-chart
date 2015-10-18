# -*- coding: utf-8 -*-

require 'erb'

class HtmlOut
	def initialize
		@linkName = ""
	end

	def create_Html(harrayCompanyInfo)
    @harrayCompanyInfo = harrayCompanyInfo
    @content = get_HtmlCode("wordpress_chart.html.erb")
	end

	private

	def get_chartName(arrayCompanyInfo)
    @arrayCompanyInfo = arrayCompanyInfo
    @name = arrayCompanyInfo[:name]
    @price = arrayCompanyInfo[:price]
    @strTickerCode = arrayCompanyInfo[:tickerCode].to_s
    @numTickerCode = arrayCompanyInfo[:tickerCode]
		@fileName = "jpeg/chart_#{@numTickerCode}.jpg"
	end

	def get_HtmlCode(fileName)
    File.open(fileName,'r:utf-8'){|f|
      ERB.new(f.read).result(binding)
    }
  end
    # ERB.new(File.read("wordpress_chart.html.erb",'r:utf-8')).result(binding)
end

harrayCompanyInfo = [
  {
    tickerCode: 2121,
    name: "日本航空",
    highPrice: "1000",
    lowPrice: "500",
    price: "700"
  },
  {
    tickerCode: 4666,
    name: " ANA",
    highPrice: "200",
    lowPrice: "300",
    price: "700"

  }
]

puts HtmlOut.new.create_Html(harrayCompanyInfo)

=begin
puts HtmlOut.new.create_Html(
  tickerCode: 2121,
  name: "日本航空",
  highPrice: "1000",
  lowPrice: "500",
  price: "700"
)
=end
