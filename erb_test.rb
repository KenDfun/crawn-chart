# -*- coding: utf-8 -*-
# encodeing: utf-8

require 'erb'

class Chart
  def initialize
    @chart_file = "hoge"
  end

  def creatChartHtml
    content = ERB.new(File.read("wordpress_chart.html.erb")).result(binding)
    puts content
  end
end

#Chart.new.creatChartHtml


class HtmlOut
	def initialize
		@linkName = ""
	end

	def create_Html(tickerCode: 2121, name: '---', highPrice: "---", lowPrice: '---', price: '---')
		@numTickerCode = tickerCode
    @strTickerCode = @numTickerCode.to_s
		@name = name
		@highPrice = highPrice
		@lowPrice = lowPrice
		@price = price
		@fileName = get_chartName(tickerCode);
    @content = get_HtmlCode("wordpress_chart.html.erb")
	end

	private

	def get_chartName(tickerCode)
		return "jpeg/chart_#{tickerCode}.jpg"
	end

	def get_HtmlCode(fileName)
    File.open(fileName,'r:utf-8'){|f|
      ERB.new(f.read).result(binding)
    }
  end
    # ERB.new(File.read("wordpress_chart.html.erb",'r:utf-8')).result(binding)
end

puts HtmlOut.new.create_Html(
  tickerCode: 2121,
  name: "日本航空",
  highPrice: "1000",
  lowPrice: "500",
  price: "700"
)
