# -*- coding: utf-8 -*-

require "net/sftp"

$HTML_HOME = "/home/kabuchk/kabu-chart.dreamhosters.com"
$SRC_HOME = "/home/kabuchk/src/crawn-chart"


class UploadToWebsite
  def initialize
    @sftp = Net::SFTP.start('kabu-chart.dreamhosters.com',"kabuchk",{:password => "dreamakari3"})
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
  webSession.upload("jpeg/chart_#{std_ticker.chomp}.jpg")
end
