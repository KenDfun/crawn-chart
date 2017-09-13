# -*- coding: utf-8 -*-

require "net/sftp"

$SRC_HOME = ENV['HOME']+"/src/crawl-chart"
$HTML_HOME = "/home/kabuchk/kabu-chart.dreamhosters.com"


class UploadToWebsite
  def initialize
    @sftp = Net::SFTP.start('kabu-chart.dreamhosters.com',"kabuchk",{:password => ENV['kabuchartpass']})
  end

  def upload(fileName)
    fullpathFileName = "#{$SRC_HOME}/#{fileName}"
    puts fullpathFileName
    @sftp.upload!(fullpathFileName,"#{$HTML_HOME}/#{fileName}")
    puts "upload: " + fileName
  end
end

webSession = UploadToWebsite.new
webSession.upload("index.html")

for std_ticker in STDIN
  webSession.upload("jpg/chart_#{std_ticker.chomp}.jpg")
end
